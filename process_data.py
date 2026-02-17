import json
import pandas as pd
import os

# ====== 1) CARGA PREDICCIONES (LABELS) ======
pred_file = "predicciones_vpam.csv"
if not os.path.exists(pred_file):
    print(f"❌ Error: {pred_file} not found in {os.getcwd()}")
    exit(1)

pred = pd.read_csv(pred_file)
# Check columns exist
required_cols = ["id_ficha", "nivel_vulnerabilidad", "vulnerabilidad_global_normalizada"]
missing = [c for c in required_cols if c not in pred.columns]
if missing:
    print(f"❌ Error: Missing columns in {pred_file}: {missing}")
    exit(1)

pred = pred[required_cols].copy()
pred["id_ficha"] = pred["id_ficha"].astype(int)

# ====== 2) CARGA FEATURES DESDE JSONL (ANIDADO EN "datos") ======
features = []
features_file = "features.jsonl"
if not os.path.exists(features_file):
    print(f"❌ Error: {features_file} not found in {os.getcwd()}")
    exit(1)

with open(features_file, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
            datos = obj.get("datos", obj)  # por si a veces viene directo sin "datos"
            features.append(datos)
        except json.JSONDecodeError as e:
            print(f"⚠️ Warning: Skipping invalid JSON line: {e}")

if not features:
    print("❌ Error: No features loaded.")
    exit(1)

df = pd.DataFrame(features)

# ---- Normaliza nombres (clave para evitar errores) ----
# si viene P36_hours_trabaja_dia, renómbrala a una sola convención
if "P36_hours_trabaja_dia" in df.columns and "P36_horas_trabaja_dia" not in df.columns:
    df = df.rename(columns={"P36_hours_trabaja_dia": "P36_horas_trabaja_dia"})

if "id_ficha" not in df.columns:
    print("❌ Error: 'id_ficha' column missing in features data.")
    exit(1)

df["id_ficha"] = df["id_ficha"].astype(int)

# ====== 3) FUNCIONES PARA ENCODIFICAR CAMPOS COMPLEJOS ======
def multi_hot(series, prefix):
    # series contiene listas (ej: ["PJUB","TRD"])
    exploded = series.apply(lambda x: x if isinstance(x, list) else [])
    # columnas por categoría
    all_cats = sorted({c for lst in exploded for c in lst})
    if not all_cats:
        return pd.DataFrame(index=series.index)
        
    out = pd.DataFrame(0, index=series.index, columns=[f"{prefix}__{c}" for c in all_cats])
    for i, lst in exploded.items():
        for c in lst:
            if f"{prefix}__{c}" in out.columns:
                out.loc[i, f"{prefix}__{c}"] = 1
    return out

def dict_to_cols(series, prefix):
    # series contiene dict (ej: {"ENERGIA_ELECTRICA": true, ...})
    # normalize handles the dict expansion
    temp_df = pd.json_normalize(series)
    temp_df.index = series.index # preserve index
    
    out = temp_df.fillna(0)
    out.columns = [f"{prefix}__{c}" for c in out.columns]
    # booleans -> 0/1
    for c in out.columns:
        out[c] = out[c].apply(lambda v: 1 if v is True else (0 if v is False else v))
    return out

def map_freq(x):
    # mapea frecuencias a escala ordinal simple (ajusta si tu tesis lo define distinto)
    mapping = {
        "NO": 0,
        "RARA_VEZ": 1,
        "MES": 2,
        "SEMANA": 3,
        "DIARIO": 4
    }
    return mapping.get(x, 0)

# ====== 4) CONSTRUYE DATASET NUMÉRICO ======
base_cols = [
    "id_ficha",
    "P19_ingreso_total_mensual",
    "miembros_hogar",
    "P21_ayuda_economica_privados",
    "P35_dias_trabaja_semana",
    "P36_horas_trabaja_dia",
    "gasto_alimentacion",
    "gasto_salud",
    "gasto_vestimenta",
    "gasto_ayudas_tecnicas",
]

# Asegura que existan (por si falta alguna columna en algunos registros)
for c in base_cols:
    if c not in df.columns:
        df[c] = None

X = df[base_cols].copy()

# --- Multi-hot / one-hot de listas ---
if "P18_origen_ingreso_familiar" in df.columns:
    X = pd.concat([X, multi_hot(df["P18_origen_ingreso_familiar"], "P18_origen_ingreso_familiar")], axis=1)

if "P24_lugar_atencion_medica" in df.columns:
    X = pd.concat([X, multi_hot(df["P24_lugar_atencion_medica"], "P24_lugar_atencion_medica")], axis=1)

if "P32_servicios_atencion" in df.columns:
    X = pd.concat([X, multi_hot(df["P32_servicios_atencion"], "P32_servicios_atencion")], axis=1)

# --- Diccionarios booleanos ---
if "P31_servicios_basicos" in df.columns:
    X = pd.concat([X, dict_to_cols(df["P31_servicios_basicos"], "P31_servicios_basicos")], axis=1)

if "P25_ayudas_tecnicas" in df.columns:
    X = pd.concat([X, dict_to_cols(df["P25_ayudas_tecnicas"], "P25_ayudas_tecnicas")], axis=1)

# --- P20_apoyo_economico_estado (dict) ---
# usamos solo respuesta principal + conteo de beneficios
if "P20_apoyo_economico_estado" in df.columns:
    p20 = df["P20_apoyo_economico_estado"].apply(lambda x: x if isinstance(x, dict) else {})
    X["P20_apoyo_estado_si"] = p20.apply(lambda d: 1 if d.get("respuesta_principal") == "SI" else 0)
    X["P20_apoyo_estado_n_beneficios"] = p20.apply(lambda d: len(d.get("detalle_beneficios", [])) if isinstance(d.get("detalle_beneficios", []), list) else 0)

# --- P27_lugar_permanencia (dict) ---
if "P27_lugar_permanencia" in df.columns:
    p27 = df["P27_lugar_permanencia"].apply(lambda x: x if isinstance(x, dict) else {})
    X["P27_lugar"] = p27.apply(lambda d: d.get("lugar", "DESCONOCIDO"))
    X["P27_tiempo"] = p27.apply(lambda d: d.get("tiempo", "DESCONOCIDO"))
    # one-hot simple
    X = pd.get_dummies(X, columns=["P27_lugar", "P27_tiempo"], dummy_na=False)

# --- P22/P23/P33/P34/P37 (categorías simples) ---
cat_cols = ["P22_pedir_dinero_alimentos", "P23_atencion_medica_frecuencia", "P33_trabaja_actualmente", "P34_ocupacion_laboral", "P37_razon_principal_trabajo"]
for c in cat_cols:
    if c in df.columns:
        X[c] = df[c].fillna("DESCONOCIDO")

existing_cat_cols = [c for c in cat_cols if c in X.columns]
if existing_cat_cols:
    X = pd.get_dummies(X, columns=existing_cat_cols, dummy_na=False)

# --- P26_consumo_sustancias (dict con frecuencias) ---
if "P26_consumo_sustancias" in df.columns:
    p26 = df["P26_consumo_sustancias"].apply(lambda x: x if isinstance(x, dict) else {})
    X["P26_alcohol"] = p26.apply(lambda d: map_freq(d.get("ALCOHOL", "NO")))
    X["P26_tabaco"] = p26.apply(lambda d: map_freq(d.get("TABACO", "NO")))
    X["P26_drogas"] = p26.apply(lambda d: map_freq(d.get("DROGAS", "NO")))

# ----- Limpieza numérica final -----
# Convert to numeric, errors='coerce' to turn non-numeric to NaN, then fillna(0)
for c in X.columns:
    if c != "id_ficha":
        X[c] = pd.to_numeric(X[c], errors="coerce")

# Rellena nulos numéricos con 0 (puedes usar mediana si quieres)
num_cols = X.select_dtypes(include=["float64", "int64"]).columns
X[num_cols] = X[num_cols].fillna(0)

# ====== 5) MERGE CON LABELS ======
# Ensure id_ficha type match
pred["id_ficha"] = pred["id_ficha"].astype(int)
X["id_ficha"] = X["id_ficha"].astype(int)

print(f"Features shape: {X.shape}")
print(f"Permissions shape: {pred.shape}")

dataset = X.merge(pred, on="id_ficha", how="inner")

# ====== 6) GUARDA DATASET FINAL ======
output_file = "dataset_model_ready.csv"
dataset.to_csv(output_file, index=False)

print(f"✅ OK - {output_file} generado")
print("Filas:", len(dataset))
print("Clases:\n", dataset["nivel_vulnerabilidad"].value_counts())
print("Columnas:", len(dataset.columns))
