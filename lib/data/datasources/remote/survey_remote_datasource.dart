import '../../../domain/entities/survey.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/entities/survey_section.dart';
import '../../../domain/entities/input_constraints.dart';
import '../../../domain/rules/condition.dart';
import '../../models/survey_model.dart';
import '../../models/question_model.dart';

abstract class SurveyRemoteDataSource {
  Future<List<Survey>> getSurveys();
}

class SurveyRemoteDataSourceFake implements SurveyRemoteDataSource {
  @override
  Future<List<Survey>> getSurveys() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final survey = SurveyModel(
      id: 'survey-001',
      title: 'Ficha de Vulnerabilidad',
      // ❗ OJO: no uses "const" aquí porque las options no necesariamente son const
      questions: [
        // =========================
        // 1) Datos Generales
        // =========================
        QuestionModel(
          id: 'idRespondeEncuestaM',
          title: '1. ¿Quién responde a ésta encuesta?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Persona posible usuario/a'),
            QuestionOption(id: '2', label: 'Familiar'),
            QuestionOption(id: '3', label: 'Otro, especifique'),
          ],
        ),
        QuestionModel(
          id: 'especifRespondeEncM',
          title: '1.1. ¿Quién Responde?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idRespondeEncuestaM',
            value: '3',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idRespondeEncuestaM',
            value: '3',
          ),
        ),
        QuestionModel(
          id: 'idTipoDocumentoM',
          title: '2. Documento de identificación del/la posible usuario/a',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Cédula'),
            QuestionOption(id: '2', label: 'Pasaporte'),
            QuestionOption(id: '3', label: 'Carnet de Refugiado'),
            QuestionOption(id: '4', label: 'No tiene'),
          ],
        ),
        QuestionModel(
          id: 'nroDocumentoM',
          title: '2.1. Nro.',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          visibleIf: const EqualsCondition(
            questionId: 'idTipoDocumentoM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idTipoDocumentoM',
            value: '1',
          ),
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 10,
            minLength: 10,
          ),
        ),
        QuestionModel(
          id: 'idNacionalidadM',
          title: '3. Nacionalidad',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Ecuatoriana'),
            QuestionOption(id: '2', label: 'Otro país'),
          ],
        ),
        QuestionModel(
          id: 'otraNacionalidadM',
          title: '3.1. ¿Cuál es el país?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idNacionalidadM',
            value: '2',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idNacionalidadM',
            value: '2',
          ),
        ),
        QuestionModel(
          id: 'Nombres',
          title: '4. Nombres',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
        ),
        QuestionModel(
          id: 'Apellidos',
          title: '5. Apellidos',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
        ),
        QuestionModel(
          id: 'fechaNacimientoM',
          title: '6. Fecha de nacimiento',
          type: QuestionType.date,
          required: false,
          section: SurveySection.datosGenerales,
        ),
        QuestionModel(
          id: 'idSexoM',
          title: '7. Identidad de Género',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Femenino'),
            QuestionOption(id: '2', label: 'Masculino'),
            QuestionOption(id: '3', label: 'Otros LGBTI+'),
          ],
        ),
        QuestionModel(
          id: 'idEstadoCivilM',
          title: '8. Estado Civil',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Soltero/a'),
            QuestionOption(id: '2', label: 'Casado/a'),
            QuestionOption(id: '3', label: 'Separado/a'),
            QuestionOption(id: '4', label: 'Divorciado/a'),
            QuestionOption(id: '5', label: 'Viudo'),
            QuestionOption(id: '6', label: 'Unión Libre'),
          ],
        ),
        QuestionModel(
          id: 'idProvinciaM',
          title: '9. Provincia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: const [],
        ),
        QuestionModel(
          id: 'idCantonM',
          title: '10. Cantón',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: const [],
        ),
        QuestionModel(
          id: 'idParroquiaM',
          title: '11. Parroquia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: const [],
        ),
        QuestionModel(
          id: 'cuenM',
          title: '12. Código único eléctrico o georreferencia X Y',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 13,
          ),
        ),
        QuestionModel(
          id: 'callePrincipalM',
          title: '13. Calle principal/camino o sendero',
          type: QuestionType.textLong,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(maxLength: 40),
        ),
        QuestionModel(
          id: 'calleSecundariaM',
          title: '14. Calle secundaria/camino o sendero',
          type: QuestionType.textLong,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(maxLength: 40),
        ),
        QuestionModel(
          id: 'referenciaUbicViM',
          title: '15. Referencia de ubicación de la vivienda',
          type: QuestionType.textLong,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(maxLength: 40),
        ),
        QuestionModel(
          id: 'telefonoM',
          title: '16.1. Teléfono Convencional:',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 9,
            minLength: 9,
          ),
        ),
        QuestionModel(
          id: 'celularM',
          title: '16.2. Celular:',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 10,
            minLength: 10,
          ),
        ),
        QuestionModel(
          id: 'correoM',
          title: '16.3. Correo electrónico:',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 80,
            pattern: r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
          ),
        ),
        QuestionModel(
          id: 'facebookMessengerM',
          title: '16.4. Facebook/Messenger:',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(maxLength: 40),
        ),
        QuestionModel(
          id: 'telefonoFamiliarM',
          title:
              '16.5. Teléfono de algún familiar o vecino donde se le pueda contactar:',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 10,
            minLength: 9,
          ),
        ),
        QuestionModel(
          id: 'viveSoloM',
          title: '17. ¿Vive Solo? (No acompañado)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idJefaturaM',
          title: '18. ¿Quién ejerce la jefatura del hogar?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Padre y Madre'),
            QuestionOption(id: '2', label: 'Madre/Padre solo'),
            QuestionOption(id: '3', label: 'Tía/o'),
            QuestionOption(
              id: '4',
              label: 'Hija/o adolescente entre 12 y 17 años',
            ),
            QuestionOption(id: '5', label: 'Hija/o joven entre 18 y 29 años'),
            QuestionOption(id: '6', label: 'Persona adulta mayor'),
            QuestionOption(id: '7', label: 'Otros NO familiares'),
          ],
          visibleIf: const EqualsCondition(questionId: 'viveSoloM', value: '0'),
          requiredIf: const EqualsCondition(
            questionId: 'viveSoloM',
            value: '0',
          ),
        ),
        QuestionModel(
          id: 'cualJefaturaM',
          title: '18.1. ¿Cuál otro no familiar?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idJefaturaM',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idJefaturaM',
            value: '7',
          ),
        ),
        // =========================
        // 2) Situación Socioeconómica
        // =========================
        QuestionModel(
          id: 'ingresoFamiliarM',
          title: '19. El ingreso familiar es producto de:',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          options: [
            QuestionOption(
              id: '1',
              label: 'Trabajo en relación de dependencia',
            ),
            QuestionOption(id: '2', label: 'Trabajo por cuenta propia'),
            QuestionOption(id: '3', label: 'Pensión por jubilación'),
            QuestionOption(id: '4', label: 'Remesas nac/int'),
            QuestionOption(id: '5', label: 'Pensión alimenticia'),
            QuestionOption(id: '6', label: 'Montepío'),
            QuestionOption(id: '7', label: 'Trueque o al partir'),
            QuestionOption(id: '8', label: 'Otro'),
          ],
        ),
        QuestionModel(
          id: 'especifOtroTipoIngresoM',
          title: '19.1. Especifique',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 13,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'ingresoFamiliarM',
            value: '8',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'ingresoFamiliarM',
            value: '8',
          ),
        ),
        QuestionModel(
          id: 'apoyoEconomicoM',
          title:
              '20. Durante el último mes, ¿recibió algún tipo de apoyo económico? ',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'tipoApoyoEconomicoM',
          title: '20.1. ¿Cuál? ',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          options: [
            QuestionOption(id: '1', label: 'Bono Joaquín Gallegos Lara'),
            QuestionOption(id: '2', label: 'Bono Variable'),
            QuestionOption(id: '3', label: 'Bono Mis mejores Años'),
            QuestionOption(id: '4', label: 'Bono de Desarrollo Humano'),
            QuestionOption(id: '5', label: 'Pensión Adultos Mayores'),
            QuestionOption(
              id: '6',
              label: 'Pensión para personas con discapacidad',
            ),
            QuestionOption(id: '7', label: 'Pensión toda una Vida'),
            QuestionOption(id: '8', label: 'Cobertura por Contingencias'),
            QuestionOption(id: '9', label: 'Bono de orfandad'),
            QuestionOption(id: '10', label: 'Otro'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'apoyoEconomicoM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'apoyoEconomicoM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'bonoOtroM',
          title: '20.1.1. Especifique',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'tipoApoyoEconomicoM',
            value: '10',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'tipoApoyoEconomicoM',
            value: '10',
          ),
        ),
        QuestionModel(
          id: 'idAyudaOrgPrivM',
          title: '21. ¿Recibe algún tipo de ayuda de organismos privados?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'cualOrgPrivM',
          title: '21.1. ¿Cuál?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idAyudaOrgPrivM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idAyudaOrgPrivM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idNecesidadPedirDineroM',
          title:
              '22. ¿Usted o alguien  de su familia, se ha visto en la necesidad de pedir dinero o alimentos en la calle? ',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          options: [
            QuestionOption(id: '1', label: 'Nunca'),
            QuestionOption(id: '2', label: 'A veces'),
            QuestionOption(id: '3', label: 'Siempre'),
          ],
        ),
        // =========================
        // 3) Salud y Nutrición
        // =========================
        QuestionModel(
          id: '56',
          title:
              '23. ¿Algún miembro del hogar recibe atención médica para tratar sus enfermedades?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFrecuenciaAtencionM',
          title: '23.1. ¿Con qué frecuencia necesita el control médico?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Mensual'),
            QuestionOption(id: '2', label: 'Bimensual'),
            QuestionOption(id: '3', label: 'Trimestral'),
            QuestionOption(id: '4', label: 'Anual'),
          ],
          visibleIf: const EqualsCondition(questionId: '56', value: '1'),
          requiredIf: const EqualsCondition(questionId: '56', value: '1'),
        ),
        QuestionModel(
          id: '58',
          title: '24. ¿En dónde recibe la asistencia médica?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sistema de Salud Público'),
            QuestionOption(id: '2', label: 'Sistema de Salud Privado'),
          ],
          visibleIf: const EqualsCondition(questionId: '56', value: '1'),
          requiredIf: const EqualsCondition(questionId: '56', value: '1'),
        ),
        QuestionModel(
          id: 'id_enfermedad_neurodegenerativa',
          title:
              '25. ¿La persona adulta mayor cuenta con algún diagnóstico de enfermedades neurodegenerativas (deterioro cognitivo, demencia, parkinson, etc)?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.saludNutricion,
        ),
        QuestionModel(
          id: 'cual_enfermedad_neurodegenerativa',
          title: '25.1. Tipo de enfermedad',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Deterioro cognitivo'),
            QuestionOption(id: '2', label: 'Demencia tipo Alzheimer'),
            QuestionOption(id: '3', label: 'Demencia mixta'),
            QuestionOption(id: '4', label: 'Demencia vascular'),
            QuestionOption(id: '5', label: 'Demencia de cuerpos de Lewy'),
            QuestionOption(id: '6', label: 'Parkinson'),
            QuestionOption(id: '7', label: 'Esclerosis Lateral Amiotrófica'),
            QuestionOption(id: '8', label: 'Atrofia muscular espinal'),
            QuestionOption(id: '9', label: 'Otros'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'id_enfermedad_neurodegenerativa',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_enfermedad_neurodegenerativa',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'otros_cual_enfermedad_neurodegenerativa',
          title: '25.1.1. ¿Cuál otra enfermedad?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.saludNutricion,
          visibleIf: const EqualsCondition(
            questionId: 'cual_enfermedad_neurodegenerativa',
            value: '9',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'cual_enfermedad_neurodegenerativa',
            value: '9',
          ),
        ),
        QuestionModel(
          id: 'idUtilizaAyudasTecnicasM',
          title:
              '26. ¿Algún miembro de la familia utiliza alguna de estas ayudas técnicas? ',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Oxígeno o respirador'),
            QuestionOption(id: '2', label: 'Silla de ruedas'),
            QuestionOption(id: '3', label: 'Andador'),
            QuestionOption(id: '4', label: 'lentes de baja visión'),
            QuestionOption(id: '5', label: 'Muletas'),
            QuestionOption(id: '6', label: 'Bastón'),
            QuestionOption(id: '7', label: 'Férulas para pies'),
            QuestionOption(id: '8', label: 'Prótesis'),
            QuestionOption(id: '9', label: 'Audífonos'),
            QuestionOption(id: '10', label: '¿Otros?'),
          ],
        ),
        QuestionModel(
          id: 'especifOtraAyudaTecUtilizaM',
          title: '26.1. ¿Cuál?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.saludNutricion,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idUtilizaAyudasTecnicasM',
            value: '10',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idUtilizaAyudasTecnicasM',
            value: '10',
          ),
        ),
        QuestionModel(
          id: 'AlcoholYesNo',
          title: '27.1. Consumo de Alcohol',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFrecuenciaAlcoholM',
          title: '27.1.1. Frecuencia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Diario'),
            QuestionOption(id: '2', label: '1 vez a la semana'),
            QuestionOption(id: '3', label: '1 vez al mes'),
            QuestionOption(id: '4', label: 'Rara vez'),
            QuestionOption(id: '5', label: 'Nunca'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'AlcoholYesNo',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'AlcoholYesNo',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'TabacoYesNo',
          title: '27.2. Consumo de Tabaco',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFrecuenciaTabacoM',
          title: '27.2.1. Frecuencia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Diario'),
            QuestionOption(id: '2', label: '1 vez a la semana'),
            QuestionOption(id: '3', label: '1 vez al mes'),
            QuestionOption(id: '4', label: 'Rara vez'),
            QuestionOption(id: '5', label: 'Nunca'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'TabacoYesNo',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'TabacoYesNo',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'DrogasYesNo',
          title: '27.3. Consumo de Drogas',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFrecuenciaDrogasIlegalesM',
          title: '27.3.1. Frecuencia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Diario'),
            QuestionOption(id: '2', label: '1 vez a la semana'),
            QuestionOption(id: '3', label: '1 vez al mes'),
            QuestionOption(id: '4', label: 'Rara vez'),
            QuestionOption(id: '5', label: 'Nunca'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'DrogasYesNo',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'DrogasYesNo',
            value: '1',
          ),
        ),
        // =========================
        // 4) Vulnerabilidad Vivienda
        // =========================
        QuestionModel(
          id: 'viviendaHabPermanece',
          title: '28. El lugar donde habitualmente permanece es:',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'Cueva'),
            QuestionOption(id: '2', label: 'Calle'),
            QuestionOption(id: '3', label: 'Albergue'),
            QuestionOption(id: '4', label: 'Hotel/ Hostal/ Motel'),
            QuestionOption(id: '5', label: 'Covacha/rancho'),
            QuestionOption(id: '6', label: 'Choza'),
            QuestionOption(id: '7', label: 'Mediagua'),
            QuestionOption(
              id: '8',
              label: 'Cuartos (Casa inquilinato/ familiar)',
            ),
            QuestionOption(id: '9', label: 'Otro'),
          ],
        ),
        QuestionModel(
          id: 'viveOtrosLugarPermaCualM',
          title: '28.1. ¿Cuál?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'viviendaHabPermanece',
            value: '9',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'viviendaHabPermanece',
            value: '9',
          ),
        ),
        QuestionModel(
          id: 'idNumCuartosM',
          title: '29. ¿De cuántos cuartos dispone su vivienda?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: '1'),
            QuestionOption(id: '2', label: '2'),
            QuestionOption(id: '3', label: '3'),
            QuestionOption(id: '4', label: '4 o más'),
          ],
        ),
        QuestionModel(
          id: 'idCuartoExclDormirM',
          title:
              '30. ¿Cuántos cuartos son utilizados exclusivamente para dormir?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: '0'),
            QuestionOption(id: '2', label: '1'),
            QuestionOption(id: '3', label: '2'),
            QuestionOption(id: '4', label: '3 o más'),
          ],
        ),
        QuestionModel(
          id: 'idNumCuartorDormirM',
          title: '31. ¿Con cuántas personas comparte el lugar para dormir?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: '1'),
            QuestionOption(id: '2', label: '2'),
            QuestionOption(id: '3', label: '3'),
            QuestionOption(id: '4', label: '4 o más'),
          ],
        ),
        QuestionModel(
          id: 'ViviendaServBasicos',
          title: '32. ¿Su vivienda dispone de...?',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'Energía eléctrica'),
            QuestionOption(id: '2', label: 'Agua consumo humano'),
            QuestionOption(id: '3', label: 'Eliminación de excretas'),
            QuestionOption(id: '4', label: 'Recolección de residuos (basura)'),
            QuestionOption(id: '5', label: 'Internet'),
          ],
        ),
        // =========================
        // 5) Servicios Atención y Cuidado
        // =========================
        QuestionModel(
          id: 'servicioAtencion',
          title: '33. Acude a un servicio de atención de…',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'MIES'),
            QuestionOption(
              id: '2',
              label: 'GAD (provincial, cantonal, parroquial)',
            ),
            QuestionOption(id: '3', label: 'Iglesia o templo'),
            QuestionOption(id: '4', label: 'Fundación / ONG'),
            QuestionOption(id: '5', label: 'Centro privado'),
            QuestionOption(id: '6', label: 'Otro, especifique'),
            QuestionOption(id: '7', label: 'Ninguno'),
          ],
        ),
        QuestionModel(
          id: 'servOtroCualM',
          title: '33.1. ¿Cuál?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '6',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '6',
          ),
        ),
        // =========================
        // 6) Ficha PAM - Trabajo
        // =========================
        QuestionModel(
          id: 'id_trabaja',
          title: '34. ¿Trabaja actualmente?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'id_ocupacion_laboral',
          title: '34.1. Si su respuesta es SI, ¿cuál es la ocupación laboral?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Funcionario Público'),
            QuestionOption(id: '2', label: 'Funcionario Privado'),
            QuestionOption(id: '3', label: 'Artesano independiente'),
            QuestionOption(id: '4', label: 'Comerciante Independiente'),
            QuestionOption(id: '5', label: 'Cuenta propia'),
            QuestionOption(
              id: '6',
              label: 'Trabajador No Remunerado del hogar',
            ),
            QuestionOption(id: '7', label: 'Empleada (o) doméstica (o)'),
            QuestionOption(id: '8', label: 'Jornalero, peón'),
            QuestionOption(id: '9', label: 'Trabajo en calle'),
            QuestionOption(id: '10', label: 'Trabajadora Sexual'),
            QuestionOption(id: '11', label: 'Desempleado'),
            QuestionOption(id: '12', label: 'Reciclador'),
            QuestionOption(id: '13', label: 'Otro'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'id_trabaja',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_trabaja',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'otro_ocupacion_laboral',
          title: '34.1.1. ¿Cuál otra ocupación?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_ocupacion_laboral',
            value: '13',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_ocupacion_laboral',
            value: '13',
          ),
        ),
        QuestionModel(
          id: 'dias_trabaja_semana',
          title: '35. ¿Cuántos días trabaja a la semana?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 1,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'id_trabaja',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'horas_trabaja_dia',
          title: '36. ¿Cuántas horas trabaja al día?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 2,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'id_trabaja',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'id_razon_trabaja',
          title: '37. ¿Cuál es la razón principal por la que trabaja?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Generar ingresos familiares'),
            QuestionOption(
              id: '2',
              label: 'Para cubrir sólo sus gastos personales',
            ),
            QuestionOption(id: '3', label: 'Para mantenerse ocupado'),
            QuestionOption(id: '4', label: 'Es obligado a trabajar'),
            QuestionOption(id: '5', label: 'Otro'),
            QuestionOption(id: '6', label: 'Ninguna'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'id_trabaja',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'otro_razon_trabaja',
          title: '37.1. ¿Cuál otra razón?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_razon_trabaja',
            value: '5',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_razon_trabaja',
            value: '5',
          ),
        ),
        // =========================
        // 7) Gastos Mensuales
        // =========================
        QuestionModel(
          id: 'id_gasto_vestimenta_pam',
          title:
              '38. Durante el último mes, ¿cuál fue el gasto exclusivamente para la persona adulta mayor en Vestimenta y calzado?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_vestimenta_pam',
          title: '38.1. Valor Mensual (Vestimenta y calzado)',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_gasto_vestimenta_pam',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_gasto_vestimenta_pam',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.decimal),
        ),
        QuestionModel(
          id: 'id_gasto_salud_pam',
          title:
              '39. Gastos en Salud (Exámenes, medicamentos, consultas, hospitalización, terapias, etc.)',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_gasto_salud_pam',
          title: '39.1. Valor Mensual (Salud)',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_gasto_salud_pam',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_gasto_salud_pam',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.decimal),
        ),
        QuestionModel(
          id: 'id_alimentacion_pam',
          title: '40. Gastos en Alimentación',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_alimentacion_pam',
          title: '40.1. Valor Mensual (Alimentación)',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_alimentacion_pam',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_alimentacion_pam',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.decimal),
        ),
        QuestionModel(
          id: 'id_gasto_ayudas_tecnicas_pam',
          title:
              '41. Gastos en Ayudas técnicas (pañales desechables, audífonos, silla de ruedas, entre otros)',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_ayuda_tecnicas_pam',
          title: '41.1. Valor Mensual (Ayudas Técnicas)',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_gasto_ayudas_tecnicas_pam',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_gasto_ayudas_tecnicas_pam',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.decimal),
        ),
        QuestionModel(
          id: 'ingresosM',
          title: '42. ¿Cuál es el ingreso total mensual del hogar?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          constraints: const InputConstraints(
            mode: InputMode.decimal,
            maxLength: 5,
          ),
        ),
      ],
    );
    return [survey];
  }
}
