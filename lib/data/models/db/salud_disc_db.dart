import 'package:uuid/uuid.dart';

class SaludDiscDb {
  final String idSaludDisc;

  final String? idTresComidasDiarias;
  final String? idProteinas;
  final String? idVegetales;
  final String? idGranos;
  final String? idFrutas;
  final String? idLacteos;
  final String? idLiquidos;
  final String? idGrasas;
  final String? idOtros;
  final String? idPerDiscHospitalizada;
  final String? porqueHospitalizacion;
  final String? idEnfermedadCatastrofica;
  final String? especifEnfCatastrofica;
  final String? tratamientoRecibe;
  final String? idRecibeTratamientoEspec;
  final String? idFrecuenciaAtencion;
  final String? idLugarAsistencia;
  final String? idNecesitaAyudasTecnicas;
  final String? idOxigenoNecesita;
  final String? idSillaRuedasNecesita;
  final String? idAndadorNecesita;
  final String? idMuletasNecesita;
  final String? idBastonNecesita;
  final String? idFerulasPiesNecesita;
  final String? idProtesisNecesita;
  final String? idAudifonosNecesita;
  final String? idOtrosAyudaTecNecesita;
  final String? especifOtraAyudaTecNecesita;
  final String? idUtilizaAyudasTecnicas;
  final String? idOxigenoUtiliza;
  final String? idSillaRuedasUtiliza;
  final String? idAndadorUtiliza;
  final String? idMuletasUtiliza;
  final String? idBastonUtiliza;
  final String? idFerulasPiesUtiliza;
  final String? idProtesisUtiliza;
  final String? idAudifonosUtiliza;
  final String? idOtrosAyudaTecUtiliza;
  final String? especifOtraAyudaTecUtiliza;
  final String? idAyudaEmergenciaFamiliar;
  final String? idVulPerDiscapacidad;
  final String? idPanialesNecesita;
  final String? idPanialesUtiliza;
  final String? idAyudaOrgPriv;
  final String? cualOrgPriv;
  final String? idNnDesnutricion;
  final String? idFamHospitalizado;

  SaludDiscDb({
    String? idSaludDisc,
    this.idTresComidasDiarias,
    this.idProteinas,
    this.idVegetales,
    this.idGranos,
    this.idFrutas,
    this.idLacteos,
    this.idLiquidos,
    this.idGrasas,
    this.idOtros,
    this.idPerDiscHospitalizada,
    this.porqueHospitalizacion,
    this.idEnfermedadCatastrofica,
    this.especifEnfCatastrofica,
    this.tratamientoRecibe,
    this.idRecibeTratamientoEspec,
    this.idFrecuenciaAtencion,
    this.idLugarAsistencia,
    this.idNecesitaAyudasTecnicas,
    this.idOxigenoNecesita,
    this.idSillaRuedasNecesita,
    this.idAndadorNecesita,
    this.idMuletasNecesita,
    this.idBastonNecesita,
    this.idFerulasPiesNecesita,
    this.idProtesisNecesita,
    this.idAudifonosNecesita,
    this.idOtrosAyudaTecNecesita,
    this.especifOtraAyudaTecNecesita,
    this.idUtilizaAyudasTecnicas,
    this.idOxigenoUtiliza,
    this.idSillaRuedasUtiliza,
    this.idAndadorUtiliza,
    this.idMuletasUtiliza,
    this.idBastonUtiliza,
    this.idFerulasPiesUtiliza,
    this.idProtesisUtiliza,
    this.idAudifonosUtiliza,
    this.idOtrosAyudaTecUtiliza,
    this.especifOtraAyudaTecUtiliza,
    this.idAyudaEmergenciaFamiliar,
    this.idVulPerDiscapacidad,
    this.idPanialesNecesita,
    this.idPanialesUtiliza,
    this.idAyudaOrgPriv,
    this.cualOrgPriv,
    this.idNnDesnutricion,
    this.idFamHospitalizado,
  }) : idSaludDisc = idSaludDisc ?? const Uuid().v4();

  static SaludDiscDb empty() => SaludDiscDb();

  SaludDiscDb copyWith({
    String? idTresComidasDiarias,
    String? idProteinas,
    String? idVegetales,
    String? idGranos,
    String? idFrutas,
    String? idLacteos,
    String? idLiquidos,
    String? idGrasas,
    String? idOtros,
    String? idPerDiscHospitalizada,
    String? porqueHospitalizacion,
    String? idEnfermedadCatastrofica,
    String? especifEnfCatastrofica,
    String? tratamientoRecibe,
    String? idRecibeTratamientoEspec,
    String? idFrecuenciaAtencion,
    String? idLugarAsistencia,
    String? idNecesitaAyudasTecnicas,
    String? idOxigenoNecesita,
    String? idSillaRuedasNecesita,
    String? idAndadorNecesita,
    String? idMuletasNecesita,
    String? idBastonNecesita,
    String? idFerulasPiesNecesita,
    String? idProtesisNecesita,
    String? idAudifonosNecesita,
    String? idOtrosAyudaTecNecesita,
    String? especifOtraAyudaTecNecesita,
    String? idUtilizaAyudasTecnicas,
    String? idOxigenoUtiliza,
    String? idSillaRuedasUtiliza,
    String? idAndadorUtiliza,
    String? idMuletasUtiliza,
    String? idBastonUtiliza,
    String? idFerulasPiesUtiliza,
    String? idProtesisUtiliza,
    String? idAudifonosUtiliza,
    String? idOtrosAyudaTecUtiliza,
    String? especifOtraAyudaTecUtiliza,
    String? idAyudaEmergenciaFamiliar,
    String? idVulPerDiscapacidad,
    String? idPanialesNecesita,
    String? idPanialesUtiliza,
    String? idAyudaOrgPriv,
    String? cualOrgPriv,
    String? idNnDesnutricion,
    String? idFamHospitalizado,
  }) {
    return SaludDiscDb(
      idSaludDisc: idSaludDisc,
      idTresComidasDiarias: idTresComidasDiarias ?? this.idTresComidasDiarias,
      idProteinas: idProteinas ?? this.idProteinas,
      idVegetales: idVegetales ?? this.idVegetales,
      idGranos: idGranos ?? this.idGranos,
      idFrutas: idFrutas ?? this.idFrutas,
      idLacteos: idLacteos ?? this.idLacteos,
      idLiquidos: idLiquidos ?? this.idLiquidos,
      idGrasas: idGrasas ?? this.idGrasas,
      idOtros: idOtros ?? this.idOtros,
      idPerDiscHospitalizada: idPerDiscHospitalizada ?? this.idPerDiscHospitalizada,
      porqueHospitalizacion: porqueHospitalizacion ?? this.porqueHospitalizacion,
      idEnfermedadCatastrofica: idEnfermedadCatastrofica ?? this.idEnfermedadCatastrofica,
      especifEnfCatastrofica: especifEnfCatastrofica ?? this.especifEnfCatastrofica,
      tratamientoRecibe: tratamientoRecibe ?? this.tratamientoRecibe,
      idRecibeTratamientoEspec: idRecibeTratamientoEspec ?? this.idRecibeTratamientoEspec,
      idFrecuenciaAtencion: idFrecuenciaAtencion ?? this.idFrecuenciaAtencion,
      idLugarAsistencia: idLugarAsistencia ?? this.idLugarAsistencia,
      idNecesitaAyudasTecnicas: idNecesitaAyudasTecnicas ?? this.idNecesitaAyudasTecnicas,
      idOxigenoNecesita: idOxigenoNecesita ?? this.idOxigenoNecesita,
      idSillaRuedasNecesita: idSillaRuedasNecesita ?? this.idSillaRuedasNecesita,
      idAndadorNecesita: idAndadorNecesita ?? this.idAndadorNecesita,
      idMuletasNecesita: idMuletasNecesita ?? this.idMuletasNecesita,
      idBastonNecesita: idBastonNecesita ?? this.idBastonNecesita,
      idFerulasPiesNecesita: idFerulasPiesNecesita ?? this.idFerulasPiesNecesita,
      idProtesisNecesita: idProtesisNecesita ?? this.idProtesisNecesita,
      idAudifonosNecesita: idAudifonosNecesita ?? this.idAudifonosNecesita,
      idOtrosAyudaTecNecesita: idOtrosAyudaTecNecesita ?? this.idOtrosAyudaTecNecesita,
      especifOtraAyudaTecNecesita: especifOtraAyudaTecNecesita ?? this.especifOtraAyudaTecNecesita,
      idUtilizaAyudasTecnicas: idUtilizaAyudasTecnicas ?? this.idUtilizaAyudasTecnicas,
      idOxigenoUtiliza: idOxigenoUtiliza ?? this.idOxigenoUtiliza,
      idSillaRuedasUtiliza: idSillaRuedasUtiliza ?? this.idSillaRuedasUtiliza,
      idAndadorUtiliza: idAndadorUtiliza ?? this.idAndadorUtiliza,
      idMuletasUtiliza: idMuletasUtiliza ?? this.idMuletasUtiliza,
      idBastonUtiliza: idBastonUtiliza ?? this.idBastonUtiliza,
      idFerulasPiesUtiliza: idFerulasPiesUtiliza ?? this.idFerulasPiesUtiliza,
      idProtesisUtiliza: idProtesisUtiliza ?? this.idProtesisUtiliza,
      idAudifonosUtiliza: idAudifonosUtiliza ?? this.idAudifonosUtiliza,
      idOtrosAyudaTecUtiliza: idOtrosAyudaTecUtiliza ?? this.idOtrosAyudaTecUtiliza,
      especifOtraAyudaTecUtiliza: especifOtraAyudaTecUtiliza ?? this.especifOtraAyudaTecUtiliza,
      idAyudaEmergenciaFamiliar: idAyudaEmergenciaFamiliar ?? this.idAyudaEmergenciaFamiliar,
      idVulPerDiscapacidad: idVulPerDiscapacidad ?? this.idVulPerDiscapacidad,
      idPanialesNecesita: idPanialesNecesita ?? this.idPanialesNecesita,
      idPanialesUtiliza: idPanialesUtiliza ?? this.idPanialesUtiliza,
      idAyudaOrgPriv: idAyudaOrgPriv ?? this.idAyudaOrgPriv,
      cualOrgPriv: cualOrgPriv ?? this.cualOrgPriv,
      idNnDesnutricion: idNnDesnutricion ?? this.idNnDesnutricion,
      idFamHospitalizado: idFamHospitalizado ?? this.idFamHospitalizado,
    );
  }

  Map<String, dynamic> toJson() => {
    'id_salud_disc': idSaludDisc,
    'id_tres_comidas_diarias': idTresComidasDiarias,
    'id_proteinas': idProteinas,
    'id_vegetales': idVegetales,
    'id_granos': idGranos,
    'id_frutas': idFrutas,
    'id_lacteos': idLacteos,
    'id_liquidos': idLiquidos,
    'id_grasas': idGrasas,
    'id_otros': idOtros,
    'id_per_disc_hospitalizada': idPerDiscHospitalizada,
    'porque_hospitalizacion': porqueHospitalizacion,
    'id_enfermedad_catastrofica': idEnfermedadCatastrofica,
    'especif_enf_catastrofica': especifEnfCatastrofica,
    'tratamiento_recibe': tratamientoRecibe,
    'id_recibe_tratamiento_espec': idRecibeTratamientoEspec,
    'id_frecuencia_atencion': idFrecuenciaAtencion,
    'id_lugar_asistencia': idLugarAsistencia,
    'id_necesita_ayudas_tecnicas': idNecesitaAyudasTecnicas,
    'id_oxigeno_necesita': idOxigenoNecesita,
    'id_silla_ruedas_necesita': idSillaRuedasNecesita,
    'id_andador_necesita': idAndadorNecesita,
    'id_muletas_necesita': idMuletasNecesita,
    'id_baston_necesita': idBastonNecesita,
    'id_ferulas_pies_necesita': idFerulasPiesNecesita,
    'id_protesis_necesita': idProtesisNecesita,
    'id_audifonos_necesita': idAudifonosNecesita,
    'id_otros_ayuda_tec_necesita': idOtrosAyudaTecNecesita,
    'especif_otra_ayuda_tec_necesita': especifOtraAyudaTecNecesita,
    'id_utiliza_ayudas_tecnicas': idUtilizaAyudasTecnicas,
    'id_oxigeno_utiliza': idOxigenoUtiliza,
    'id_silla_ruedas_utiliza': idSillaRuedasUtiliza,
    'id_andador_utiliza': idAndadorUtiliza,
    'id_muletas_utiliza': idMuletasUtiliza,
    'id_baston_utiliza': idBastonUtiliza,
    'id_ferulas_pies_utiliza': idFerulasPiesUtiliza,
    'id_protesis_utiliza': idProtesisUtiliza,
    'id_audifonos_utiliza': idAudifonosUtiliza,
    'id_otros_ayuda_tec_utiliza': idOtrosAyudaTecUtiliza,
    'especif_otra_ayuda_tec_utiliza': especifOtraAyudaTecUtiliza,
    'id_ayuda_emergencia_familiar': idAyudaEmergenciaFamiliar,
    'id_vul_per_discapacidad': idVulPerDiscapacidad,
    // Nota: Mantuve el camelCase en el JSON porque así venía en tu lista original (ej. idPanialesNecesita)
    'idPanialesNecesita': idPanialesNecesita,
    'idPanialesUtiliza': idPanialesUtiliza,
    'id_ayuda_org_priv': idAyudaOrgPriv,
    'cual_org_priv': cualOrgPriv,
    'id_nn_desnutricion': idNnDesnutricion,
    'id_fam_hospitalizado': idFamHospitalizado,
  };

  static SaludDiscDb fromJson(Map<String, dynamic> json) {
    return SaludDiscDb(
      idSaludDisc: (json['id_salud_disc'] as String?) ?? const Uuid().v4(),
      idTresComidasDiarias: json['id_tres_comidas_diarias'] as String?,
      idProteinas: json['id_proteinas'] as String?,
      idVegetales: json['id_vegetales'] as String?,
      idGranos: json['id_granos'] as String?,
      idFrutas: json['id_frutas'] as String?,
      idLacteos: json['id_lacteos'] as String?,
      idLiquidos: json['id_liquidos'] as String?,
      idGrasas: json['id_grasas'] as String?,
      idOtros: json['id_otros'] as String?,
      idPerDiscHospitalizada: json['id_per_disc_hospitalizada'] as String?,
      porqueHospitalizacion: json['porque_hospitalizacion'] as String?,
      idEnfermedadCatastrofica: json['id_enfermedad_catastrofica'] as String?,
      especifEnfCatastrofica: json['especif_enf_catastrofica'] as String?,
      tratamientoRecibe: json['tratamiento_recibe'] as String?,
      idRecibeTratamientoEspec: json['id_recibe_tratamiento_espec'] as String?,
      idFrecuenciaAtencion: json['id_frecuencia_atencion'] as String?,
      idLugarAsistencia: json['id_lugar_asistencia'] as String?,
      idNecesitaAyudasTecnicas: json['id_necesita_ayudas_tecnicas'] as String?,
      idOxigenoNecesita: json['id_oxigeno_necesita'] as String?,
      idSillaRuedasNecesita: json['id_silla_ruedas_necesita'] as String?,
      idAndadorNecesita: json['id_andador_necesita'] as String?,
      idMuletasNecesita: json['id_muletas_necesita'] as String?,
      idBastonNecesita: json['id_baston_necesita'] as String?,
      idFerulasPiesNecesita: json['id_ferulas_pies_necesita'] as String?,
      idProtesisNecesita: json['id_protesis_necesita'] as String?,
      idAudifonosNecesita: json['id_audifonos_necesita'] as String?,
      idOtrosAyudaTecNecesita: json['id_otros_ayuda_tec_necesita'] as String?,
      especifOtraAyudaTecNecesita: json['especif_otra_ayuda_tec_necesita'] as String?,
      idUtilizaAyudasTecnicas: json['id_utiliza_ayudas_tecnicas'] as String?,
      idOxigenoUtiliza: json['id_oxigeno_utiliza'] as String?,
      idSillaRuedasUtiliza: json['id_silla_ruedas_utiliza'] as String?,
      idAndadorUtiliza: json['id_andador_utiliza'] as String?,
      idMuletasUtiliza: json['id_muletas_utiliza'] as String?,
      idBastonUtiliza: json['id_baston_utiliza'] as String?,
      idFerulasPiesUtiliza: json['id_ferulas_pies_utiliza'] as String?,
      idProtesisUtiliza: json['id_protesis_utiliza'] as String?,
      idAudifonosUtiliza: json['id_audifonos_utiliza'] as String?,
      idOtrosAyudaTecUtiliza: json['id_otros_ayuda_tec_utiliza'] as String?,
      especifOtraAyudaTecUtiliza: json['especif_otra_ayuda_tec_utiliza'] as String?,
      idAyudaEmergenciaFamiliar: json['id_ayuda_emergencia_familiar'] as String?,
      idVulPerDiscapacidad: json['id_vul_per_discapacidad'] as String?,
      idPanialesNecesita: json['idPanialesNecesita'] as String?,
      idPanialesUtiliza: json['idPanialesUtiliza'] as String?,
      idAyudaOrgPriv: json['id_ayuda_org_priv'] as String?,
      cualOrgPriv: json['cual_org_priv'] as String?,
      idNnDesnutricion: json['id_nn_desnutricion'] as String?,
      idFamHospitalizado: json['id_fam_hospitalizado'] as String?,
    );
  }
}