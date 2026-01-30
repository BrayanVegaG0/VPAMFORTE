# Documentación Completa - Sistema de Ficha de Vulnerabilidad para Adultos Mayores con Discapacidad

## Índice

1. [Descripción General](#1-descripción-general)
2. [Arquitectura del Sistema](#2-arquitectura-del-sistema)
3. [Modelos de Datos](#3-modelos-de-datos)
4. [Escalas de Evaluación Implementadas](#4-escalas-de-evaluación-implementadas)
5. [Flujo de Datos](#5-flujo-de-datos)
6. [Integración SOAP](#6-integración-soap)
7. [Pruebas con SoapUI](#7-pruebas-con-soapui)
8. [Configuración y Desarrollo](#8-configuración-y-desarrollo)
9. [Guía de Uso](#9-guía-de-uso)

---

## 1. Descripción General

### 1.1 Propósito del Sistema

Este aplicativo móvil desarrollado en Flutter permite la recolección de información detallada sobre adultos mayores con discapacidad a través de un formulario estructurado de encuesta. El sistema recoge datos de:

- **Datos personales y demográficos**
- **Información socioeconómica**
- **Condiciones de salud**
- **Evaluaciones funcionales** (Índice de Barthel, Escala de Lawton & Brody)
- **Evaluaciones cognitivas** (Mini-Mental State Examination - MMSE)
- **Evaluación de depresión** (Escala de Depresión Geriátrica de Yesavage)

### 1.2 Tecnologías Utilizadas

- **Framework**: Flutter (Dart)
- **Gestión de Estado**: flutter_bloc
- **Persistencia**: Modelos de datos con serialización JSON
- **Integración Backend**: SOAP Web Services
- **Generación de IDs**: UUID

---

## 2. Arquitectura del Sistema

### 2.1 Arquitectura Limpia (Clean Architecture)

El proyecto sigue los principios de Clean Architecture con 3 capas principales:

```
lib/
├── domain/           # Lógica de negocio y entidades
│   ├── entities/     # Modelos de dominio
│   └── rules/        # Reglas de negocio (condiciones)
├── data/             # Capa de datos
│   ├── models/       # Modelos de datos (DB, DTOs)
│   ├── datasources/  # Fuentes de datos (remote, local)
│   └── mappers/      # Conversores de datos
└── presentation/     # Capa de presentación (UI)
    ├── pages/
    ├── widgets/
    └── state/        # BLoCs para gestión de estado
```

### 2.2 Patrón de Diseño Utilizado

- **BLoC (Business Logic Component)**: Separación de lógica de negocio y UI
- **Repository Pattern**: Abstracción del acceso a datos
- **Mapper Pattern**: Transformación entre modelos de diferentes capas
- **Factory Pattern**: Creación de objetos complejos (serialización)

---

## 3. Modelos de Datos

### 3.1 Modelo Principal: FichaAdultoMayorDiscDb

El modelo agregador principal que contiene todas las secciones de la ficha:

```dart
class FichaAdultoMayorDiscDb {
  final VulnerabilidadPerDiscapacidadDb vulnerabilidadPerDiscapacidad;
  final FamiliasFactoresRiesgoDb familiasFactoresRiesgo;
  final VulnerabilidadViviendaDiscDb vulnerabilidadViviendaDisc;
  final IngGastosDiscDb ingGastosDisc;
  final SaludDiscDb saludDisc;
  final FichaPamDb fichaPam;
  final IndiceBarthelDiscDb indiceBarthel;
  final LawtonBrodyDb lawtonBrody;
  final MiniMentalPamDb minimentalPam;
  final YesavagePamDb yesavagePam;
}
```

### 3.2 Secciones de la Ficha

#### 3.2.1 VulnerabilidadPerDiscapacidadDb
**Ruta**: `lib/data/models/db/vulnerabilidad_per_discapacidad_db.dart`

Contiene información personal y demográfica:
- Datos de identificación (documento, nombre, fecha de nacimiento)
- Datos de contacto (teléfono, correo, ubicación geográfica)
- Información de nacionalidad, sexo, estado civil
- Red de apoyo familiar y social
- Acceso a servicios de salud y servicios sociales

#### 3.2.2 FamiliasFactoresRiesgoDb
**Ruta**: `lib/data/models/db/familias_factores_riesgo_db.dart`

Información sobre la estructura familiar y factores de riesgo:
- Composición familiar
- Factores de riesgo (alcohol, tabaco, drogas)
- Situación económica familiar
- Estructura habitacional

#### 3.2.3 VulnerabilidadViviendaDiscDb
**Ruta**: `lib/data/models/db/vulnerabilidad_vivienda_disc_db.dart`

Características de la vivienda:
- Tipo de vivienda
- Servicios básicos (agua, luz, alcantarillado)
- Tenencia de la vivienda
- Condiciones físicas

#### 3.2.4 IngGastosDiscDb
**Ruta**: `lib/data/models/db/ing_gastos_disc_db.dart`

Información económica:
- Ingresos del hogar
- Fuentes de ingreso
- Gastos principales

#### 3.2.5 SaludDiscDb
**Ruta**: `lib/data/models/db/salud_disc_db.dart`

Estado de salud:
- Enfermedades crónicas
- Medicación actual
- Acceso a servicios de salud
- Ayudas técnicas utilizadas

#### 3.2.6 FichaPamDb
**Ruta**: `lib/data/models/db/ficha_pam_db.dart`

Ficha específica del Programa del Adulto Mayor (PAM):
- Datos de educación y alfabetización
- Etnia y autoidentificación
- Historial laboral
- Gastos específicos del adulto mayor
- Necesidades de cuidado
- Información sobre cuidadores
- Medicamentos utilizados
- Historial de caídas
- Condiciones de accesibilidad en la vivienda

#### 3.2.7 IndiceBarthelDiscDb
**Ruta**: `lib/data/models/db/indice_barthel_disc_db.dart`

Escala de evaluación de actividades básicas de la vida diaria (10 ítems):
- Comer
- Trasladarse de la silla a la cama
- Aseo personal
- Uso del retrete
- Bañarse
- Desplazarse
- Subir/bajar escaleras
- Vestirse/desvestirse
- Control de heces
- Control de orina

#### 3.2.8 LawtonBrodyDb
**Ruta**: `lib/data/models/db/lawton_brody_db.dart`

Escala de evaluación de actividades instrumentales de la vida diaria (8 ítems):
- Capacidad para usar el teléfono
- Hacer compras
- Preparar comida
- Cuidado de la casa
- Lavado de ropa
- Uso de medios de transporte
- Responsabilidad sobre medicación
- Capacidad para utilizar dinero

#### 3.2.9 MiniMentalPamDb
**Ruta**: `lib/data/models/db/minimental_pam_db.dart`

Mini-Mental State Examination (MMSE) - Evaluación cognitiva (30 puntos):
- **Orientación temporal** (5 puntos): año, estación, día, mes, día de la semana
- **Orientación espacial** (5 puntos): lugar, piso, ciudad, provincia, país
- **Memoria inmediata** (3 puntos): repetición de 3 palabras
- **Atención y cálculo** (5 puntos): series de restas
- **Memoria diferida** (3 puntos): recuerdo de las 3 palabras
- **Lenguaje y denominación** (2 puntos): nombrar objetos
- **Repetición** (1 punto): repetir frase
- **Comprensión** (3 puntos): seguir órdenes verbales
- **Lectura** (1 punto): leer y ejecutar orden
- **Escritura** (1 punto): escribir una frase
- **Copia** (1 punto): copiar dibujo

Campos adicionales para totales por categoría: `totalTiempo`, `totalEspacio`, `totalMemoria`, etc.

#### 3.2.10 YesavagePamDb
**Ruta**: `lib/data/models/db/yesavage_pam_db.dart`

Escala de Depresión Geriátrica de Yesavage (GDS-15) - 15 preguntas Sí/No:
1. ¿Está básicamente satisfecho con su vida?
2. ¿Ha renunciado a muchas de sus actividades e intereses?
3. ¿Siente que su vida está vacía?
4. ¿Se encuentra a menudo aburrido?
5. ¿La mayor parte del tiempo está de buen humor?
6. ¿Teme que le pase algo malo?
7. ¿Se siente feliz la mayor parte del tiempo?
8. ¿Se siente a menudo abandonado?
9. ¿Prefiere quedarse en casa en lugar de salir?
10. ¿Cree que tiene más problemas de memoria que la mayoría?
11. ¿Cree que vivir es maravilloso?
12. ¿Le cuesta iniciar nuevos proyectos?
13. ¿Se siente lleno de energía?
14. ¿Siente que su situación es desesperada?
15. ¿Cree que la mayoría de la gente está mejor que usted?

Cada respuesta se almacena como `'1'` (Sí) o `'0'` (No).

---

## 4. Escalas de Evaluación Implementadas

### 4.1 Índice de Barthel

**Propósito**: Evaluar la independencia funcional en actividades básicas de la vida diaria.

**Puntuación**:
- 0-20 puntos: Dependencia total
- 21-60 puntos: Dependencia severa
- 61-90 puntos: Dependencia moderada
- 91-99 puntos: Dependencia leve
- 100 puntos: Independiente

**Ubicación de preguntas**: `lib/data/datasources/remote/survey_remote_datasource.dart` (líneas ~2500-2600)

### 4.2 Escala de Lawton & Brody

**Propósito**: Evaluar la capacidad para realizar actividades instrumentales de la vida diaria.

**Puntuación**:
- 0-1 puntos: Dependencia total
- 2-3 puntos: Dependencia severa
- 4-5 puntos: Dependencia moderada
- 6-7 puntos: Dependencia leve
- 8 puntos: Independiente

**Ubicación de preguntas**: `lib/data/datasources/remote/survey_remote_datasource.dart` (líneas ~2600-2700)

### 4.3 Mini-Mental State Examination (MMSE)

**Propósito**: Evaluación del deterioro cognitivo.

**Puntuación**:
- 27-30 puntos: Sin deterioro cognitivo
- 24-26 puntos: Deterioro cognitivo leve
- 19-23 puntos: Deterioro cognitivo moderado
- <19 puntos: Deterioro cognitivo severo

**Ubicación de preguntas**: `lib/data/datasources/remote/survey_remote_datasource.dart` (líneas ~2720-2900)

### 4.4 Escala de Depresión Geriátrica (Yesavage GDS-15)

**Propósito**: Detección de síntomas depresivos en adultos mayores.

**Puntuación**:
- 0-5 puntos: Normal
- 6-9 puntos: Depresión leve
- 10-15 puntos: Depresión establecida

**Ubicación de preguntas**: `lib/data/datasources/remote/survey_remote_datasource.dart` (líneas ~2900-3100)

---

## 5. Flujo de Datos

### 5.1 Secuencia de Procesamiento

```
1. Usuario completa encuesta en UI
   ↓
2. BLoC (SurveyBloc) recibe eventos de respuestas
   ↓
3. Respuestas se almacenan en Map<String, dynamic>
   ↓
4. SurveyAnswersToFichaDbMapper convierte Map a FichaAdultoMayorDiscDb
   ↓
5. FichaSoapSerializer genera XML SOAP envelope
   ↓
6. SurveySoapRemoteDataSource envía petición SOAP al backend
   ↓
7. Backend procesa y almacena datos
```

### 5.2 Mapper: Transformación de Datos

**Archivo**: `lib/data/mappers/survey_answers_to_ficha_db_mapper.dart`

El mapper transforma las respuestas del formulario (formato clave-valor) a los modelos de datos estructurados:

```dart
class SurveyAnswersToFichaDbMapper {
  FichaAdultoMayorDiscDb map(Map<String, dynamic> answers) {
    return FichaAdultoMayorDiscDb(
      vulnerabilidadPerDiscapacidad: _mapVulnerabilidad(answers),
      familiasFactoresRiesgo: _mapFamilias(answers),
      // ... otros mapeos
      indiceBarthel: _mapIndiceBarthel(answers),
      lawtonBrody: _mapLawtonBrody(answers),
      minimentalPam: _mapMiniMental(answers),
      yesavagePam: _mapYesavage(answers),
    );
  }
}
```

**Funciones auxiliares importantes**:
- `_s(dynamic v)`: Convierte a String, maneja nulos
- `_date(dynamic v)`: Convierte a formato de fecha ISO
- `_bool01(dynamic v)`: Convierte booleanos a '1' o '0'
- `_has(dynamic v, String optionId)`: Verifica si una opción está seleccionada en multi-select

---

## 6. Integración SOAP

### 6.1 Serialización SOAP

**Archivo**: `lib/data/datasources/remote/soap/ficha_soap_serializer.dart`

Este componente genera el XML SOAP envelope completo para enviar al backend.

#### 6.1.1 Estructura del Envelope

```xml
<?xml version="1.0" encoding="utf-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ns1="http://impl.service.siimies.web.ficha.vulnerabilidad/">
  <soapenv:Header/>
  <soapenv:Body>
    <ns1:insertFichaAdultoMayorDisc>
      <vulnerabilidadPerDiscapacidad>...</vulnerabilidadPerDiscapacidad>
      <familiasFactoresRiesgo>...</familiasFactoresRiesgo>
      <vulnerabilidadViviendaDisc>...</vulnerabilidadViviendaDisc>
      <ingGastosDisc>...</ingGastosDisc>
      <saludDisc>...</saludDisc>
      <fichaPam>...</fichaPam>
      <indiceBarthelDisc>...</indiceBarthelDisc>
      <lawtonBrody>...</lawtonBrody>
      <minimentalPam>...</minimentalPam>
      <yesavagePam>...</yesavagePam>
    </ns1:insertFichaAdultoMayorDisc>
  </soapenv:Body>
</soapenv:Envelope>
```

#### 6.1.2 Manejo de Primary Keys

Las Primary Keys (IDs) generadas localmente con UUID se fuerzan a `0` en el XML para INSERT:

```dart
static const Set<String> _pkTags = {
  'idVulPerDiscapacidad',
  'idFichaPam',
  'idIndiceBarthelDisc',
  'idLawtonBrody',
  'idMinimentalPam',
  'idYesavagePam',
  // ...
};
```

#### 6.1.3 Escapado de Caracteres XML

El método `_t()` escapa caracteres especiales:
- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `"` → `&quot;`
- `'` → `&apos;`

### 6.2 Datasource SOAP

**Archivo**: `lib/data/datasources/remote/survey_soap_remote_datasource.dart`

Maneja la comunicación HTTP con el servicio SOAP.

---

## 7. Pruebas con SoapUI

### 7.1 Instalación de SoapUI

1. Descargar SoapUI desde: https://www.soapui.org/downloads/soapui/
2. Instalar siguiendo el asistente de instalación
3. Ejecutar SoapUI

### 7.2 Configuración del Proyecto

#### 7.2.1 Crear Nuevo Proyecto SOAP

1. En SoapUI: **File** → **New SOAP Project**
2. **Project Name**: FichaVulnerabilidadPAM
3. **Initial WSDL**: Ingresar la URL del WSDL del servicio backend
   - Ejemplo: `http://[servidor]/ficha-vulnerabilidad/services/FichaAdultoMayorService?wsdl`
4. Click en **OK**

#### 7.2.2 Ejemplo de WSDL (Referencia)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<definitions xmlns="http://schemas.xmlsoap.org/wsdl/"
             targetNamespace="http://impl.service.siimies.web.ficha.vulnerabilidad/">
  <types>
    <!-- Definiciones de tipos -->
  </types>
  <message name="insertFichaAdultoMayorDiscRequest">
    <!-- Definición del mensaje de request -->
  </message>
  <portType name="FichaAdultoMayorServicePortType">
    <operation name="insertFichaAdultoMayorDisc">
      <!-- Definición de la operación -->
    </operation>
  </portType>
</definitions>
```

### 7.3 Preparar Request de Prueba

#### 7.3.1 Solicitud Mínima de Ejemplo

En SoapUI, bajo el proyecto creado, expandir:
**FichaAdultoMayorService** → **FichaAdultoMayorServiceSoapBinding** → **insertFichaAdultoMayorDisc**

Hacer doble click en **Request 1** para abrir el editor.

#### 7.3.2 XML de Prueba Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:ns1="http://impl.service.siimies.web.ficha.vulnerabilidad/">
  <soapenv:Header/>
  <soapenv:Body>
    <ns1:insertFichaAdultoMayorDisc>
      <vulnerabilidadPerDiscapacidad>
        <idVulPerDiscapacidad>0</idVulPerDiscapacidad>
        <nroDocumento>1234567890</nroDocumento>
        <nombresApellidos>Juan Pérez González</nombresApellidos>
        <fechaNacimiento>1950-05-15</fechaNacimiento>
        <idSexo>1</idSexo>
        <idEstadoCivil>2</idEstadoCivil>
        <telefono>0987654321</telefono>
        <!-- Más campos según sea necesario -->
      </vulnerabilidadPerDiscapacidad>
      
      <familiasFactoresRiesgo>
        <idFamFactoresRiesgos>0</idFamFactoresRiesgos>
        <idJefatura>1</idJefatura>
        <!-- Más campos -->
      </familiasFactoresRiesgo>
      
      <vulnerabilidadViviendaDisc>
        <idVulViviendaDisc>0</idVulViviendaDisc>
        <!-- Campos de vivienda -->
      </vulnerabilidadViviendaDisc>
      
      <ingGastosDisc>
        <idIngGastosDisc>0</idIngGastosDisc>
        <!-- Campos de ingresos -->
      </ingGastosDisc>
      
      <saludDisc>
        <idSaludDisc>0</idSaludDisc>
        <!-- Campos de salud -->
      </saludDisc>
      
      <fichaPam>
        <idFichaPam>0</idFichaPam>
        <idEtnia>1</idEtnia>
        <idEducacion>2</idEducacion>
        <!-- Más campos PAM -->
      </fichaPam>
      
      <indiceBarthelDisc>
        <idIndiceBarthelDisc>0</idIndiceBarthelDisc>
        <idComer>10</idComer>
        <idTrasladoSillaCama>15</idTrasladoSillaCama>
        <idAseoPersonal>5</idAseoPersonal>
        <idUsoRetrete>10</idUsoRetrete>
        <idBaniarse>5</idBaniarse>
        <idDesplazarse>15</idDesplazarse>
        <idSubirBajarEscaleras>10</idSubirBajarEscaleras>
        <idVestirseDesvestirse>10</idVestirseDesvestirse>
        <idControlHeces>10</idControlHeces>
        <idControlOrina>10</idControlOrina>
      </indiceBarthelDisc>
      
      <lawtonBrody>
        <idLawtonBrody>0</idLawtonBrody>
        <idCapacidadTelefono>1</idCapacidadTelefono>
        <idHacerCompras>1</idHacerCompras>
        <idPrepararComida>1</idPrepararComida>
        <idCuidadoCasa>1</idCuidadoCasa>
        <idLavadoRopa>1</idLavadoRopa>
        <idTransporte>1</idTransporte>
        <idMedicacion>1</idMedicacion>
        <idUtilizarDinero>1</idUtilizarDinero>
      </lawtonBrody>
      
      <minimentalPam>
        <idMinimentalPam>0</idMinimentalPam>
        <idTiempoUno>1</idTiempoUno>
        <idTiempoDos>1</idTiempoDos>
        <idTiempoTres>1</idTiempoTres>
        <idTiempoCuatro>1</idTiempoCuatro>
        <idTiempoCinco>1</idTiempoCinco>
        <idEspacioUno>1</idEspacioUno>
        <idEspacioDos>1</idEspacioDos>
        <idEspacioTres>1</idEspacioTres>
        <idEspacioCuatro>1</idEspacioCuatro>
        <idEspacioCinco>1</idEspacioCinco>
        <idMemoriaUno>1</idMemoriaUno>
        <idMemoriaDos>1</idMemoriaDos>
        <idMemoriaTres>1</idMemoriaTres>
        <idCalculoUno>1</idCalculoUno>
        <idCalculoDos>1</idCalculoDos>
        <idCalculoTres>1</idCalculoTres>
        <idCalculoCuatro>1</idCalculoCuatro>
        <idCalculoCinco>1</idCalculoCinco>
        <idMemoriaDifUno>1</idMemoriaDifUno>
        <idMemoriaDifDos>1</idMemoriaDifDos>
        <idMemoriaDifTres>1</idMemoriaDifTres>
        <idDenominacionUno>1</idDenominacionUno>
        <idDenominacionDos>1</idDenominacionDos>
        <idRepeticionUno>1</idRepeticionUno>
        <idComprensionUno>1</idComprensionUno>
        <idComprensionDos>1</idComprensionDos>
        <idComprensionTres>1</idComprensionTres>
        <idLecturaUno>1</idLecturaUno>
        <idEscrituraUno>1</idEscrituraUno>
        <idCopiaUno>1</idCopiaUno>
      </minimentalPam>
      
      <yesavagePam>
        <idYesavagePam>0</idYesavagePam>
        <idYesavageUno>0</idYesavageUno>
        <idYesavageDos>1</idYesavageDos>
        <idYesavageTres>1</idYesavageTres>
        <idYesavageCuatro>1</idYesavageCuatro>
        <idYesavageCinco>0</idYesavageCinco>
        <idYesavageSeis>1</idYesavageSeis>
        <idYesavageSiete>0</idYesavageSiete>
        <idYesavageOcho>1</idYesavageOcho>
        <idYesavageNueve>1</idYesavageNueve>
        <idYesavageDiez>1</idYesavageDiez>
        <idYesavageOnce>0</idYesavageOnce>
        <idYesavageDoce>1</idYesavageDoce>
        <idYesavageTrece>0</idYesavageTrece>
        <idYesavageCatorce>1</idYesavageCatorce>
        <idYesavageQuince>1</idYesavageQuince>
      </yesavagePam>
      
    </ns1:insertFichaAdultoMayorDisc>
  </soapenv:Body>
</soapenv:Envelope>
```

### 7.4 Ejecución de Pruebas

#### 7.4.1 Configurar Endpoint

1. En la parte superior de la ventana de Request, verificar el **Endpoint URL**
2. Ejemplo: `http://[servidor]:8080/ficha-vulnerabilidad/services/FichaAdultoMayorService`

#### 7.4.2 Ejecutar Request

1. Click en el botón verde de **Play (▶)** en la barra superior
2. Observar la respuesta en el panel derecho

#### 7.4.3 Respuestas Esperadas

**Éxito (200 OK)**:
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:insertFichaAdultoMayorDiscResponse>
      <return>
        <status>SUCCESS</status>
        <message>Ficha registrada correctamente</message>
        <id>12345</id>
      </return>
    </ns1:insertFichaAdultoMayorDiscResponse>
  </soap:Body>
</soap:Envelope>
```

**Error de Validación (500 Internal Server Error)**:
```xml
<soap:Fault>
  <faultcode>soap:Server</faultcode>
  <faultstring>Error de validación: Campo 'nroDocumento' es requerido</faultstring>
</soap:Fault>
```

### 7.5 Casos de Prueba Recomendados

#### 7.5.1 Caso 1: Registro Completo
- **Objetivo**: Verificar inserción exitosa con todos los campos
- **Datos**: Completar todos los modelos con valores válidos
- **Resultado esperado**: Status SUCCESS

#### 7.5.2 Caso 2: Campos Mínimos Requeridos
- **Objetivo**: Verificar cuáles son los campos obligatorios
- **Datos**: Solo campos esenciales (documento, nombre, fechaNacimiento)
- **Resultado esperado**: Identificar campos faltantes

#### 7.5.3 Caso 3: Validación de Escalas
- **Objetivo**: Verificar cálculo de puntajes de escalas
- **Datos**: Valores específicos en Barthel, Lawton, MMSE, Yesavage
- **Resultado esperado**: Verificar que los totales se calculen correctamente

#### 7.5.4 Caso 4: Caracteres Especiales
- **Objetivo**: Verificar escapado correcto de XML
- **Datos**: Incluir caracteres como `<`, `>`, `&`, `"`, `'` en campos de texto
- **Resultado esperado**: No debe generar XML mal formado

### 7.6 Assertions en SoapUI

Agregar validaciones automáticas:

1. Click derecho en el Request → **Add Assertion**
2. Tipos de assertions útiles:
   - **Contains**: Verificar que la respuesta contenga "SUCCESS"
   - **SOAP Response**: Validar estructura SOAP
   - **XPath Match**: Verificar valores específicos en la respuesta
   - **Response Time**: Asegurar que responda en menos de X segundos

Ejemplo de XPath Assertion:
```xpath
//return/status/text() = 'SUCCESS'
```

---

## 8. Configuración y Desarrollo

### 8.1 Requisitos Previos

- **Flutter SDK**: ≥ 2.12.0
- **Dart SDK**: ≥ 2.12.0
- **IDE**: Android Studio, VS Code con extensiones de Flutter
- **Emulador/Dispositivo**: Android/iOS

### 8.2 Instalación del Proyecto

```bash
# Clonar el repositorio
cd ficha_vulnerabilidad-master-507a278778ebd8ea29447f16530a655144f12a83

# Instalar dependencias
flutter pub get

# Ejecutar análisis estático
flutter analyze

# Ejecutar tests
flutter test

# Ejecutar la aplicación
flutter run
```

### 8.3 Dependencias Principales

**pubspec.yaml**:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^X.X.X      # Gestión de estado
  uuid: ^X.X.X              # Generación de IDs
  http: ^X.X.X              # Cliente HTTP
  # Otras dependencias...
```

### 8.4 Configuración del Backend

Modificar la URL del servicio SOAP en:
**Archivo**: `lib/data/datasources/remote/survey_soap_remote_datasource.dart`

```dart
final String _endpoint = 'http://[TU_SERVIDOR]/ficha-vulnerabilidad/services/FichaAdultoMayorService';
```

### 8.5 Estructura de Directorios Completa

```
lib/
├── domain/
│   ├── entities/
│   │   ├── survey_section.dart          # Enum de secciones
│   │   ├── question_model.dart          # Modelo de pregunta
│   │   └── question_option.dart         # Modelo de opción
│   └── rules/
│       └── condition.dart               # Condiciones de visibilidad
├── data/
│   ├── models/
│   │   └── db/
│   │       ├── ficha_adulto_mayor_disc_db.dart
│   │       ├── vulnerabilidad_per_discapacidad_db.dart
│   │       ├── familias_factores_riesgo_db.dart
│   │       ├── vulnerabilidad_vivienda_disc_db.dart
│   │       ├── ing_gastos_disc_db.dart
│   │       ├── salud_disc_db.dart
│   │       ├── ficha_pam_db.dart
│   │       ├── indice_barthel_disc_db.dart
│   │       ├── lawton_brody_db.dart
│   │       ├── minimental_pam_db.dart
│   │       └── yesavage_pam_db.dart
│   ├── datasources/
│   │   └── remote/
│   │       ├── survey_remote_datasource.dart
│   │       ├── survey_soap_remote_datasource.dart
│   │       └── soap/
│   │           └── ficha_soap_serializer.dart
│   └── mappers/
│       └── survey_answers_to_ficha_db_mapper.dart
└── presentation/
    ├── pages/
    ├── widgets/
    └── state/
        └── survey/
            ├── survey_bloc.dart
            ├── survey_event.dart
            └── survey_state.dart
```

---

## 9. Guía de Uso

### 9.1 Flujo del Usuario

1. **Iniciar Aplicación**: El usuario abre la aplicación móvil
2. **Seleccionar Sección**: Navega por las secciones del formulario
3. **Completar Datos**: Responde preguntas en cada sección
4. **Validación en Tiempo Real**: El sistema valida las respuestas
5. **Revisión**: El usuario puede revisar respuestas antes de enviar
6. **Envío**: Se envía la información al backend vía SOAP
7. **Confirmación**: Recibe confirmación de registro exitoso

### 9.2 Secciones del Formulario (Orden Sugerido)

1. **Vulnerabilidad Personal** - Datos de identificación
2. **Familia y Factores de Riesgo** - Composición familiar
3. **Vivienda** - Características de la vivienda
4. **Ingresos y Gastos** - Situación económica
5. **Salud** - Estado de salud general
6. **Ficha PAM** - Información específica del programa
7. **Índice de Barthel** - Evaluación funcional básica
8. **Lawton & Brody** - Evaluación funcional instrumental
9. **Mini-Mental** - Evaluación cognitiva
10. **Yesavage** - Detección de depresión

### 9.3 Validaciones Implementadas

- **Campos requeridos**: Marcados con asterisco (*)
- **Formato de documentos**: Validación de cédula/identificación
- **Rangos de edad**: Verificación de fechas coherentes
- **Dependencias lógicas**: Preguntas condicionales según respuestas previas
- **Formato de contacto**: Validación de teléfonos y emails

### 9.4 Manejo de Errores

El sistema maneja los siguientes errores:

1. **Error de Conexión**: Mensaje al usuario, opción de reintentar
2. **Error de Validación**: Destacar campos con problemas
3. **Error del Servidor**: Mensaje informativo, contactar soporte
4. **Timeout**: Opción de reenvío automático

---

## 10. Mantenimiento y Extensión

### 10.1 Agregar Nueva Escala de Evaluación

Para agregar una nueva escala (ejemplo: "Escala de Dolor"):

1. **Crear modelo de datos**:
   ```dart
   // lib/data/models/db/escala_dolor_db.dart
   class EscalaDolorDb {
     final String idEscalaDolor;
     final String? nivelDolor;
     // ... otros campos
   }
   ```

2. **Actualizar modelo agregador**:
   ```dart
   // lib/data/models/db/ficha_adulto_mayor_disc_db.dart
   class FichaAdultoMayorDiscDb {
     // ... campos existentes
     final EscalaDolorDb escalaDolor;
   }
   ```

3. **Agregar sección al enum**:
   ```dart
   // lib/domain/entities/survey_section.dart
   enum SurveySection {
     // ... existentes
     escalaDolor,
   }
   ```

4. **Definir preguntas**:
   ```dart
   // lib/data/datasources/remote/survey_remote_datasource.dart
   QuestionModel(
     id: 'nivel_dolor',
     title: '¿Cuál es su nivel de dolor?',
     section: SurveySection.escalaDolor,
     // ...
   )
   ```

5. **Implementar mapper**:
   ```dart
   // lib/data/mappers/survey_answers_to_ficha_db_mapper.dart
   EscalaDolorDb _mapEscalaDolor(Map<String, dynamic> a) {
     return EscalaDolorDb(
       idEscalaDolor: const Uuid().v4(),
       nivelDolor: _s(a['nivel_dolor']),
     );
   }
   ```

6. **Actualizar serializer**:
   ```dart
   // lib/data/datasources/remote/soap/ficha_soap_serializer.dart
   String _escalaDolor(FichaAdultoMayorDiscDb f) {
     final x = f.escalaDolor;
     // ... generar XML
   }
   ```

### 10.2 Modificar Endpoint SOAP

Para cambiar la URL del servicio:

1. Ubicar archivo: `lib/data/datasources/remote/survey_soap_remote_datasource.dart`
2. Modificar la constante `_endpoint`
3. Verificar namespace en `ficha_soap_serializer.dart`

### 10.3 Análisis de Código

```bash
# Verificar calidad del código
flutter analyze

# Formatear código
flutter format .

# Ejecutar tests
flutter test
```

---

## 11. Solución de Problemas Comunes

### 11.1 Error: "The method '_mapMiniMental' isn't defined"

**Causa**: Faltan imports o el método no está implementado.

**Solución**:
```dart
import '../models/db/minimental_pam_db.dart';
import '../models/db/yesavage_pam_db.dart';
```

### 11.2 Error SOAP: "Unexpected character"

**Causa**: Caracteres especiales no escapados en XML.

**Solución**: Verificar que el método `_t()` del serializer esté escapando correctamente.

### 11.3 Respuesta vacía del servidor

**Causa**: Endpoint incorrecto o servidor no disponible.

**Solución**:
1. Verificar conectividad de red
2. Confirmar URL del endpoint
3. Verificar logs del servidor backend

### 11.4 Diferencias en IDs entre app y backend

**Causa**: Los IDs UUID locales deben ser 0 para INSERT.

**Solución**: Verificar que los PKs estén en `_pkTags` del serializer.

---

## 12. Contacto y Soporte

Para soporte técnico o reportar problemas:

- **Equipo de Desarrollo**: [correo@ejemplo.com]
- **Documentación del Backend**: [URL_DOCS_BACKEND]
- **Repositorio**: [URL_REPOSITORIO]

---

## Anexos

### Anexo A: Diccionario de Campos Importantes

| Campo | Tipo | Descripción | Valores |
|-------|------|-------------|---------|
| `idTipoDocumento` | String | Tipo de documento de identidad | 1=Cédula, 2=Pasaporte |
| `idSexo` | String | Sexo biológico | 1=Masculino, 2=Femenino |
| `idEstadoCivil` | String | Estado civil | 1=Soltero, 2=Casado, 3=Viudo, etc. |
| `idEtnia` | String | Autoidentificación étnica | Valores definidos por catálogo |

### Anexo B: Códigos de Error SOAP Comunes

| Código | Descripción | Acción Recomendada |
|--------|-------------|-------------------|
| 500 | Error interno del servidor | Revisar logs del backend |
| 400 | Solicitud mal formada | Verificar estructura XML |
| 401 | No autorizado | Verificar credenciales |
| 404 | Endpoint no encontrado | Verificar URL del servicio |

---

**Versión del Documento**: 1.0  
**Fecha**: 2026-01-30  
**Autor**: Sistema de Documentación Automática
