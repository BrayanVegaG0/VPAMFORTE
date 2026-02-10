import '../../../domain/entities/input_constraints.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/entities/survey_section.dart';
import '../../models/survey_model.dart';
import '../../models/question_model.dart';
import 'package:ficha_vulnerabilidad/domain/rules/condition.dart';

abstract class SurveyRemoteDataSource {
  Future<List<SurveyModel>> getSurveys();
}

class SurveyRemoteDataSourceFake implements SurveyRemoteDataSource {
  @override
  Future<List<SurveyModel>> getSurveys() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

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
          id: 'idServMdh',
          title: '2. ¿Qué servicio requiere del MDH?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Protección Especial'),
            QuestionOption(id: '2', label: 'Desarrollo Infantil'),
            QuestionOption(id: '3', label: 'Adulto Mayor'),
            QuestionOption(id: '4', label: 'Discapacidad'),
          ],
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
        // ========================
        // FALTA 12PROVINCIA,13CANTON,14PARROQUIA
        // ========================
        QuestionModel(
          id: 'idProvinciaM', // o idProvinciaM si prefieres, pero debe coincidir con el const del widget
          title: '12. Provincia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: const [], // se ignora
        ),
        QuestionModel(
          id: 'idCantonM',
          title: '13. Cantón',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: const [],
        ),
        QuestionModel(
          id: 'idParroquiaM',
          title: '14. Parroquia',
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
        // Seccion contacto
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
              '16.5. Teléfono de algún familiar o vecino donde se le pueda contactar::',
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
          title: '¿Cuál otro no familiar?',
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
        // ========================
        // Seccion familia 19. GENERAR UNA PERSONA EN ESTA PARTE;
        // ========================
        QuestionModel(
          id: 'personasHogarM',
          title: '19. Personas que viven en el hogar',
          type: QuestionType.householdMembers,
          required: false,
          section: SurveySection.datosGenerales,
        ),
        QuestionModel(
          id: 'idContactoFamiliaresM',
          title: '1#. ¿Mantiene contacto con familiares o laguien cercano?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
          visibleIf: const EqualsCondition(questionId: 'viveSoloM', value: '1'),
          requiredIf: const EqualsCondition(
            questionId: 'viveSoloM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'contactoFamiliaresM',
          title: '1#.1. Con quién mantiene contacto:',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Padres'),
            QuestionOption(id: '2', label: 'Padre'),
            QuestionOption(id: '3', label: 'Madre'),
            QuestionOption(id: '4', label: 'Hijos/as'),
            QuestionOption(id: '5', label: 'Hermanos/as'),
            QuestionOption(id: '6', label: 'Nietos'),
            QuestionOption(id: '7', label: 'Otros familiares'),
            QuestionOption(id: '8', label: 'Otros no familiares'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idContactoFamiliaresM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idContactoFamiliaresM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'cualContactoFamiliaresM',
          title: '¿Cuál otro no familiar?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'contactoFamiliaresM',
            value: '8',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'contactoFamiliaresM',
            value: '8',
          ),
        ),

        QuestionModel(
          id: 'idNnaSeparadoM',
          title:
              '20. ¿Algún NNA que es parte del hogar, se encuentra en condición de separado de sus progenitores?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFrecuenciaActividadesRecreM',
          title:
              '21. ¿Con qué frecuencia realiza actividades de esparcimiento y recreación?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Siempre'),
            QuestionOption(id: '2', label: 'Ocasionalmente'),
            QuestionOption(id: '3', label: 'Rara vez'),
            QuestionOption(id: '4', label: 'Nunca'),
          ],
        ),
        QuestionModel(
          id: 'idComunicaEntornoM',
          title:
          '22. ¿Con quién de su vecindad/entorno/comunidad, se comunica usted?',
          type: QuestionType
              .dropdown, //Se debe cambiar a multichoise porque no tengo campos aun en la BD
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'vecino/a'),
            QuestionOption(id: '2', label: 'policía'),
            QuestionOption(id: '3', label: 'tendero/a'),
            QuestionOption(id: '4', label: 'líder/esa'),
            QuestionOption(id: '5', label: 'panadero/a'),
            QuestionOption(id: '6', label: 'párroco/pastor'),
            QuestionOption(id: '7', label: 'otros'),
          ],
        ),
        QuestionModel(
          id: 'dondeFrecuenciaActividadesRecreM',
          title: '21.1. ¿Dónde?',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'en el domicilio'),
            QuestionOption(id: '2', label: 'en casa de amigos'),
            QuestionOption(id: '3', label: 'en el parque'),
            QuestionOption(id: '4', label: 'en la finca'),
            QuestionOption(id: '5', label: 'en la playa'),
            QuestionOption(id: '6', label: 'en la montaña'),
          ],
          visibleIf: const OneOfCondition(
            questionId: 'idFrecuenciaActividadesRecreM',
            values: ['1', '2', '3'],
          ),
          requiredIf: const OneOfCondition(
            questionId: 'idFrecuenciaActividadesRecreM',
            values: ['1', '2', '3'],
          ),
        ),

        QuestionModel(
          id: 'comunicaEntornoOtrosM',
          title: '¿Cuál otro?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idComunicaEntornoM',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idComunicaEntornoM',
            value: '7',
          ),
        ),
        QuestionModel(
          id: 'idFamDesaM',
          title:
              '23. ¿Conoce si algún miembro de su familia se encuentra desaparecido?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'famDesaParentescoM',
          title: '23.1. Parentesco',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Padre'),
            QuestionOption(id: '2', label: 'Madre'),
            QuestionOption(id: '3', label: 'Tío/a'),
            QuestionOption(id: '4', label: 'Primo'),
            QuestionOption(id: '5', label: 'Hijo'),
            QuestionOption(id: '6', label: 'Hermano'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamDesaM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamDesaM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'famDesaTiempoM',
          title: '23.2. ¿Desde hace que tiempo?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idFamDesaM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamDesaM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idTrabaFueraM',
          title:
              '24. Algún miembro de la familia se encuentra trabajando fuera del país?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'trabaFueraParentescoM',
          title: '24.1. Parentesco',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Padre'),
            QuestionOption(id: '2', label: 'Madre'),
            QuestionOption(id: '3', label: 'Tío/a'),
            QuestionOption(id: '4', label: 'Primo'),
            QuestionOption(id: '5', label: 'Hijo'),
            QuestionOption(id: '6', label: 'Hermano'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idTrabaFueraM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idTrabaFueraM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'trabaFueraDondeM',
          title: 'cantón, provincia, país',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idTrabaFueraM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idTrabaFueraM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idFamEsOtroPaisM',
          title:
              '25. Algún miembro de la familia es de otro país, ¿hace cuánto tiempo ingreso? ',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idTiempoIngresoM',
          title: '25.1. ¿Hace qué tiempo?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'menos de un mes'),
            QuestionOption(id: '2', label: 'entre un mes y tres meses'),
            QuestionOption(id: '3', label: 'entre tres y seis meses'),
            QuestionOption(id: '4', label: 'entre seis meses y un año'),
            QuestionOption(id: '5', label: 'más de un año'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'famEsOtroPaisDondeM',
          title: '26. ¿De qué país es?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 20,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idTieneVisadoEcuatM',
          title: '27. ¿Tiene visado ecuatoriano? ',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.datosGenerales,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamEsOtroPaisM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'numVisadoEcuatM',
          title: '27.1. Nro.',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.datosGenerales,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 13,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'idTieneVisadoEcuatM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idTieneVisadoEcuatM',
            value: '1',
          ),
        ),
        // =========================
        // 2) Situación Socioeconómica
        // =========================
        QuestionModel(
          id: 'ingresoFamiliarM',
          title: '28. El ingreso familiar es producto de:',
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
          title: '28.1. Especifique',
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
          id: 'ingresosM',
          title: '29. ¿Cuál es el ingreso total mensual del hogar?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.situacionSocioEconomica,
          constraints: const InputConstraints(
            mode: InputMode.decimal,
            maxLength: 5,
          ),
        ),
        QuestionModel(
          id: 'apoyoEconomicoM',
          title:
              '30. Durante el último mes, ¿recibió algún tipo de apoyo económico? ',
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
          title: '30.1. ¿Cuál? ',
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
        ),
        QuestionModel(
          id: 'bonoOtroM',
          title: '30.1.1. Especifique',
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
          title: '31. ¿Recibe algún tipo de ayuda de organismos privados?',
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
          title: '31.1. ¿Cuál?',
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
              '32. ¿Usted o alguien  de su familia, se ha visto en la necesidad de pedir dinero o alimentos en la calle? ',
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
          id: 'idNnDesnutricionM',
          title:
              '33. ¿Algún NN de la familia tiene desnutrición crónica o severa? ',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFamHospitalizadoM',
          title:
              '34. ¿Algún miembro del hogar ha estado hospitalizada durante los últimos 6 meses?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.saludNutricion,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: '55',
          title: '34.1. ¿Por qué?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.saludNutricion,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 40,
          ),
          visibleIf: const EqualsCondition(questionId: '54', value: '1'),
          requiredIf: const EqualsCondition(questionId: '54', value: '1'),
        ),
        QuestionModel(
          id: '56',
          title:
              '35. ¿Algún miembro del hogar recibe atención médica para tratar sus enfermedades?',
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
          title: '35.1. ¿Con qué frecuencia necesita el control médico?',
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
          title: '36. ¿En dónde recibe la asistencia médica?',
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
          id: 'idUtilizaAyudasTecnicasM',
          title:
              '37. ¿Algún miembro de la familia utiliza alguna de estas ayudas técnicas? ',
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
          title: '37.1. ¿Cuál?',
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
        // Titulo familia consume
        QuestionModel(
          id: 'AlcoholYesNo',
          title: '38.1. Alcohol',
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
          title: '38.1.1. Frecuencia',
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
          title: '38.2. Tabaco',
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
          title: '38.2.1. Frecuencia',
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
          title: '38.2. Drogas',
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
          title: '38.2.1. Frecuencia',
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
          id: 'viviendaRiesgo',
          title:
              '39. La vivienda ha pasado por eventos de riesgo en el último año como:',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(
              id: '1',
              label: 'Deslizamientos de tierra / deslaves',
            ),
            QuestionOption(id: '2', label: 'Inundaciones'),
            QuestionOption(id: '3', label: 'Sequía'),
            QuestionOption(id: '4', label: 'Terremoto / maremoto/ Tsunami'),
            QuestionOption(id: '5', label: 'Actividades volcánicas'),
            QuestionOption(id: '6', label: 'Incendios forestales'),
            QuestionOption(
              id: '7',
              label: 'Contaminación por industrias/minería/petróleo',
            ),
            QuestionOption(
              id: '8',
              label: 'Explosión por gas/ distribuidoras de gas/gasolina',
            ),
          ],
        ),
        QuestionModel(
          id: 'viviendaZonasTolerancia',
          title: '40. La vivienda está ubicada en zonas de tolerancia',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'Bares'),
            QuestionOption(id: '2', label: 'Discotecas'),
            QuestionOption(id: '3', label: 'Cantinas'),
            QuestionOption(id: '4', label: 'Burdeles'),
          ],
        ),
        QuestionModel(
          id: 'viviendaHabPermanece',
          title: '41. El lugar donde habitualmente permanece es:',
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
          title: '41.1. ¿Cuál?',
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
          id: 'idViveMasSeisMesesM',
          title: '41.2. ¿Cuánto tiempo?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'menos 6 meses'),
            QuestionOption(id: '2', label: 'más de seis meses'),
          ],
        ),
        // FALTA QIE SE MUESTRE SOLO SI SE SELECCIONA LAS OPCIONES CORRESPONDIENTES, SI NO NO SE DEBERÏAN MOSTrAR
        QuestionModel(
          id: 'idNumCuartosM',
          title: '42. ¿De cuántos cuartos dispone su vivienda?',
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
              '43. ¿Cuántos cuartos son utilizados exclusivamente para dormir?',
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
          title: '44. ¿Con cuántas personas comparte el lugar para dormir?',
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
          id: 'idLugarDuermeM',
          title: '45. ¿Para dormir la persona utiliza?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.vulnerabilidadVivienda,
          options: [
            QuestionOption(id: '1', label: 'cama'),
            QuestionOption(id: '2', label: 'estera'),
            QuestionOption(id: '3', label: 'colchón'),
            QuestionOption(id: '4', label: 'cartón'),
            QuestionOption(id: '5', label: 'hamaca'),
            QuestionOption(id: '6', label: 'suelo'),
          ],
        ),
        QuestionModel(
          id: 'ViviendaServBasicos',
          title: '46. ¿Su vivienda dispone de...?',
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
          id: 'idFamPrivLibertadM',
          title:
              '47. ¿Tiene un familiar cercano privado de la libertad o con medida socioeducativa?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idFamRelaPrivLibM',
          title: '47.1. Relación con el/la posible usuario/a: ',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Padre/Madre'),
            QuestionOption(id: '2', label: 'Hijos/as'),
            QuestionOption(id: '3', label: 'Hermanos/as'),
            QuestionOption(id: '4', label: 'Nietos'),
            QuestionOption(id: '5', label: 'Otros familiares'),
            QuestionOption(id: '6', label: 'Otros no familiares'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idFamTipoPrivLibM',
          title: '47.2. ¿Qué tipo de medida de privación de Libertad tiene? ',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Centro de Privación de Libertad'),
            QuestionOption(id: '2', label: 'Centro de Rehabilitación Social'),
            QuestionOption(id: '3', label: 'Arresto Domiciliario'),
            QuestionOption(id: '4', label: 'Dispositivo electrónico'),
            QuestionOption(
              id: '5',
              label: 'Centro de Adolescentes Infractores',
            ),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'idTieneSentenciaM',
          title: '48. ¿Tiene sentencia?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'idFamPrivLibertadM',
            value: '1',
          ),
        ),
        QuestionModel(
          id: 'usuarioSeguro',
          title: '49. ¿El/la representate o posible usuario/a tiene seguro? ',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'IESS'),
            QuestionOption(id: '2', label: 'ISSFA'),
            QuestionOption(id: '3', label: 'ISSPOL'),
            QuestionOption(id: '4', label: 'Privado'),
            QuestionOption(id: '5', label: 'IESS Campesino'),
            QuestionOption(id: '6', label: 'Ninguno'),
          ],
        ),
        //AGREGAR FUNCIONALIDAD DE NINGUNO
        //AGREGAR QUE SE PINTE DE ROJO CUANDO UNA PREGUNTA NO ESTÄ RESPONDIDA Y QUE DESAPAREZCA INSTANTANEAMENTE CUANDO SE RESPONDA
        QuestionModel(
          id: 'servicioAtencion',
          title: '50. Acude a un servicio de atención de…',
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
          title: '50.1. ¿Cuál?',
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
        QuestionModel(
          id: 'noAsisteServPorQue',
          title: '51. ¿Por qué NO asiste?',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'No tengo tiempo para ir'),
            QuestionOption(id: '2', label: 'Distante / no tengo transporte'),
            QuestionOption(id: '3', label: 'No tengo dinero'),
            QuestionOption(id: '4', label: 'Tengo malas referencias'),
            QuestionOption(id: '5', label: 'Otro'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
        ),
        QuestionModel(
          id: 'otroNoAsisteCualM',
          title: '51.1. Especifique',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 50,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'noAsisteServPorQue',
            value: '5',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'noAsisteServPorQue',
            value: '5',
          ),
        ),
        QuestionModel(
          id: 'idTiempoLlegarServMiesM',
          title:
              '52. ¿En caso de ser seleccionado/a. Cuánto tiempo demora/ría en llegar al servicio de atención?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Menos de 30 minutos'),
            QuestionOption(id: '2', label: 'De 30 a 60 minutos'),
            QuestionOption(id: '3', label: 'De una a dos horas'),
            QuestionOption(id: '4', label: 'Mas de dos horas'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
        ),
        QuestionModel(
          id: 'idTransporteLlegadaM',
          title:
              '53. ¿Qué tipo de transporte utiliza/ría para llagar al servicio?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Bus'),
            QuestionOption(id: '2', label: 'Taxi'),
            QuestionOption(id: '3', label: 'Tricimoto'),
            QuestionOption(id: '4', label: 'Carro propio'),
            QuestionOption(id: '5', label: 'Camioneta'),
            QuestionOption(id: '6', label: 'Lancha'),
            QuestionOption(id: '7', label: 'Animales'),
            QuestionOption(id: '8', label: 'Ninguno'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
        ),
        QuestionModel(
          id: 'porqueAsistiria',
          title: '54. ¿Por qué asisti/ría?',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          options: [
            QuestionOption(id: '1', label: 'Necesito lugar donde vivir'),
            QuestionOption(id: '2', label: 'Necesito alimentación'),
            QuestionOption(
              id: '3',
              label: 'Requiere protección ante violencia intrafamiliar',
            ),
            QuestionOption(
              id: '4',
              label: 'Desarrollo de habilidades sociales y económicas',
            ),
            QuestionOption(id: '5', label: 'Otro'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'servicioAtencion',
            value: '7',
          ),
        ),
        QuestionModel(
          id: 'otroNecesitaCualM',
          title: '54.1. Especifique',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.serviciosAtencionCuidado,
          constraints: const InputConstraints(
            mode: InputMode.text,
            maxLength: 50,
          ),
          visibleIf: const EqualsCondition(
            questionId: 'porqueAsistiria',
            value: '5',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'porqueAsistiria',
            value: '5',
          ),
        ),
        // =========================
        // 6) Cuestionario AMA
        // =========================
        QuestionModel(
          id: 'idAmaPregUnoM',
          title: '55. ¿Alguien en casa le ha hecho daño alguna vez?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregDosM',
          title:
              '56. ¿Alguien ha tocado su cuerpo alguna vez sin su consentimiento?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregTresM',
          title:
              '57. ¿Alguien le ha obligado alguna vez a hacer cosas que no quería?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregCuatroM',
          title: '58. ¿Alguien ha cogido cosas suyas sin preguntarle?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregCincoM',
          title: '59. ¿Alguien le ha amenazado alguna vez?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregSeisM',
          title: '60. ¿Ha firmado alguna vez documentos que no entendía?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregSieteM',
          title: '61. ¿Tiene miedo de alguien en casa?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregOchoM',
          title: '62. ¿Estás solo muchas veces/mucho tiempo?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        QuestionModel(
          id: 'idAmaPregNueveM',
          title:
              '63. ¿Alguien no le ha ayudado a cuidarse cuando lo necesitaba?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.cuestionarioAMA,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '0', label: 'No'),
          ],
        ),
        // =========================
        // 6) Ficha Adulto Mayor
        // =========================
        QuestionModel(
          id: 'idFichaPam',
          title: '36. ¿Tiene ficha adulto mayor?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'fecha_nacimiento', // fecha_nacimiento provided by user
          title: 'Fecha de nacimiento',
          type: QuestionType.date,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'id_ced_con_discapacidad',
          title: '¿Tiene cédula con discapacidad?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'numero_cedula',
          title: 'Número de cédula',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_ced_con_discapacidad',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_ced_con_discapacidad',
            value: 'true',
          ),
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 10,
          ),
        ),
        QuestionModel(
          id: 'porcentaje_discapacidad',
          title: 'Porcentaje de discapacidad',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_ced_con_discapacidad',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_ced_con_discapacidad',
            value: 'true',
          ),
          constraints: const InputConstraints(
            mode: InputMode.integer,
            maxLength: 3,
          ),
        ),
        QuestionModel(
          id: 'id_etnia',
          title: 'Etnia',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Mestiza'),
            QuestionOption(id: '2', label: 'Indígena'),
            QuestionOption(id: '3', label: 'Afrodescendiente'),
            QuestionOption(id: '4', label: 'Montuvio'),
            QuestionOption(id: '5', label: 'Blanco'),
            QuestionOption(id: '6', label: 'Otros'),
          ],
        ),
        QuestionModel(
          id: 'id_etnia_indigena',
          title: 'Etnia Indígena',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Kichwa'),
            QuestionOption(id: '2', label: 'Shuar'),
            QuestionOption(id: '3', label: 'Achuar'),
            QuestionOption(id: '26', label: 'Otra'),
          ],
          visibleIf: const EqualsCondition(questionId: 'id_etnia', value: '2'),
          requiredIf: const EqualsCondition(questionId: 'id_etnia', value: '2'),
        ),
        QuestionModel(
          id: 'id_idioma',
          title: 'Idioma',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Español'),
            QuestionOption(id: '2', label: 'Lengua nativa'),
            QuestionOption(id: '3', label: 'Lengua extranjera'),
            QuestionOption(id: '4', label: 'Lengua de señas'),
            QuestionOption(id: '5', label: 'Comunicación escrita'),
            QuestionOption(id: '6', label: 'Braille'),
            QuestionOption(id: '7', label: 'JAWS'),
            QuestionOption(id: '8', label: 'No puede comunicarse'),
          ],
        ),
        QuestionModel(
          id: 'id_lengua_nativa',
          title: 'Lengua Nativa',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Kichwa'),
            QuestionOption(id: '2', label: 'Shuar Chicham'),
          ],
          visibleIf: const EqualsCondition(questionId: 'id_idioma', value: '2'),
          requiredIf: const EqualsCondition(
            questionId: 'id_idioma',
            value: '2',
          ),
        ),
        QuestionModel(
          id: 'id_instruccion',
          title: 'Instrucción',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Ninguno'),
            QuestionOption(id: '2', label: 'Centro de alfabetización'),
            QuestionOption(id: '3', label: 'Jardín de infantes'),
            QuestionOption(id: '4', label: 'Primaria'),
            QuestionOption(id: '5', label: 'EGB'),
            QuestionOption(id: '6', label: 'Secundaria'),
            QuestionOption(id: '7', label: 'Bachillerato'),
            QuestionOption(id: '8', label: 'Superior'),
            QuestionOption(id: '9', label: 'Postgrado'),
          ],
        ),
        QuestionModel(
          id: 'id_grado',
          title: 'Grado/Curso',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: '1ro'),
            QuestionOption(id: '2', label: '2do'),
            QuestionOption(id: '3', label: '3er'),
            QuestionOption(id: '4', label: '4to'),
            QuestionOption(id: '5', label: '5to'),
            QuestionOption(id: '6', label: '6to'),
            QuestionOption(id: '7', label: '7mo'),
            QuestionOption(id: '8', label: '8vo'),
            QuestionOption(id: '9', label: '9mo'),
            QuestionOption(id: '10', label: '10mo'),
            QuestionOption(id: '11', label: '1ro BGU'),
            QuestionOption(id: '12', label: '2do BGU'),
            QuestionOption(id: '13', label: '3er BGU'),
          ],
          visibleIf: const OneOfCondition(
            questionId: 'id_instruccion',
            values: ['4', '5', '6', '7'],
          ),
        ),
        QuestionModel(
          id: 'id_trabaja',
          title: '¿Trabaja?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'id_ocupacion_laboral',
          title: 'Ocupación Laboral',
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
          title: '¿Cuál otra ocupación?',
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
          title: 'Días que trabaja a la semana',
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
          title: 'Horas que trabaja al día',
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
          title: 'Razón por la que trabaja',
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
          title: '¿Cuál otra razón?',
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
        QuestionModel(
          id: 'id_gasto_vestimenta_pam',
          title: 'Gastos: Vestimenta y Calzado',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_vestimenta_pam',
          title: 'Valor Mensual (Vestimenta)',
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
          title: 'Gastos: Salud',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_gasto_salud_pam',
          title: 'Valor Mensual (Salud)',
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
          title: 'Gastos: Alimentación',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_alimentacion_pam',
          title: 'Valor Mensual (Alimentación)',
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
          title: 'Gastos: Ayudas Técnicas',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'valor_ayuda_tecnicas_pam',
          title: 'Valor Mensual (Ayudas Técnicas)',
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
          id: 'id_requiere_cuidados',
          title: '¿Requiere usted cuidados de alguien?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'id_cuenta_persona_cuide',
          title: '¿Cuenta usted con una persona que le cuide?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_requiere_cuidados',
            value: 'true',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_requiere_cuidados',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'id_quien_cuidados_domicilio',
          title: '¿De quién recibe cuidados en su domicilio?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Familiar'),
            QuestionOption(id: '2', label: 'Cuidadores privados'),
            QuestionOption(id: '3', label: 'Otros'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'id_requiere_cuidados',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'otros_quien_cuidados_dom',
          title: '¿Otro cuidador?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_quien_cuidados_domicilio',
            value: '3',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_quien_cuidados_domicilio',
            value: '3',
          ),
        ),
        QuestionModel(
          id: 'tipo_ayuda_familiar',
          title:
              '¿Qué tipo de ayuda recibe de sus familiares u otras personas?',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Dinero'),
            QuestionOption(id: '2', label: 'Comida'),
            QuestionOption(id: '3', label: 'Ropa'),
            QuestionOption(id: '4', label: 'Quehaceres domésticos'),
            QuestionOption(id: '5', label: 'Cuidado personal'),
            QuestionOption(id: '6', label: 'Transporte'),
            QuestionOption(id: '7', label: 'Entretenimiento'),
            QuestionOption(id: '8', label: 'Compañía'),
            QuestionOption(id: '9', label: 'Ninguna'),
            QuestionOption(id: '10', label: 'Otro'),
          ],
        ),
        QuestionModel(
          id: 'cual_ayuda_fam_otro',
          title: '¿Cuál otra ayuda?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const ContainsCondition(
            questionId: 'tipo_ayuda_familiar',
            value: '10',
          ),
          requiredIf: const ContainsCondition(
            questionId: 'tipo_ayuda_familiar',
            value: '10',
          ),
        ),
        QuestionModel(
          id: 'id_frecuencia_ayuda_fam',
          title: '¿Con qué frecuencia recibe usted esta ayuda?',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Diario'),
            QuestionOption(id: '2', label: 'Semanal'),
            QuestionOption(id: '3', label: 'Mensual'),
            QuestionOption(id: '4', label: 'Anual'),
          ],
        ),
        QuestionModel(
          id: 'id_pam_cuida_personas',
          title: '¿La persona adulta mayor cuida a otras personas?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'cuantos_nn_pam_cuida',
          title: '¿Cuántos NNA cuida?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuantos_adolescentes_pam_cuida',
          title: '¿Cuántos adolescentes cuida?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuantos_pcd_pam_cuida',
          title: '¿Cuántos personas con discapacidad cuida?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuantos_pam_cuida',
          title: '¿Cuántos adultos mayores cuida?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuantos_otros_pam_cuida',
          title: '¿Cuántos otros cuida?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuales_otros_pam_cuida',
          title: '¿Cuáles otros?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_pam_cuida_personas',
            value: 'true',
          ),
        ),
        QuestionModel(
          id: 'cuantos_medicamentos_utiliza_pam',
          title: '¿Cuántos medicamentos utiliza diariamente?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'cuantas_veces_caido_pam_seis_meses',
          title: '¿En los últimos 6 meses cuántas veces se ha caído?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'id_problemas_dientes_pam_doce_meses',
          title: 'Frecuencia problemas dientes (12 meses)',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Siempre'),
            QuestionOption(id: '2', label: 'A veces'),
            QuestionOption(id: '3', label: 'Nunca'),
          ],
        ),
        QuestionModel(
          id: 'id_come_tres_comidas_diarias',
          title: '¿Come usted al menos tres comidas diarias?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'id_sindrome_golondrina',
          title: '¿Vive usted en un solo lugar (Síndrome de golondrina)?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'num_domicilios_rota',
          title: '¿Número de domicilios por los que rota?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_sindrome_golondrina',
            value: 'false',
          ),
          requiredIf: const EqualsCondition(
            questionId: 'id_sindrome_golondrina',
            value: 'false',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'tiempo_pasa_cada_domicilio',
          title: '¿Tiempo promedio (semanas/año) en cada domicilio?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
          visibleIf: const EqualsCondition(
            questionId: 'id_sindrome_golondrina',
            value: 'false',
          ),
          constraints: const InputConstraints(mode: InputMode.integer),
        ),
        QuestionModel(
          id: 'id_enfermedad_neurodegenerativa',
          title: '¿Diagnóstico de enfermedades neurodegenerativas?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'cual_enfermedad_neurodegenerativa',
          title: 'Tipo de enfermedad',
          type: QuestionType.dropdown,
          required: false,
          section: SurveySection.fichaPam,
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
          title: '¿Cuál otra enfermedad?',
          type: QuestionType.textShort,
          required: false,
          section: SurveySection.fichaPam,
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
          id: 'id_vivienda_accesibilidad',
          title: '¿La vivienda cuenta con accesibilidad?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.fichaPam,
        ),
        QuestionModel(
          id: 'accesibilidad_vivienda',
          title: 'Elementos de accesibilidad',
          type: QuestionType.multiChoice,
          required: false,
          section: SurveySection.fichaPam,
          options: [
            QuestionOption(id: '1', label: 'Rampas'),
            QuestionOption(id: '2', label: 'escaleras con pasamanos'),
            QuestionOption(id: '3', label: 'cerraduras de manija'),
            QuestionOption(id: '4', label: 'baños con agarraderas'),
            QuestionOption(id: '5', label: 'ventilación natural'),
            QuestionOption(id: '6', label: 'iluminación natural'),
            QuestionOption(id: '7', label: 'Traslado fácil'),
          ],
          visibleIf: const EqualsCondition(
            questionId: 'id_vivienda_accesibilidad',
            value: 'true',
          ),
        ),
        // =========================
        // 7) Indice Barthel
        // =========================
        QuestionModel(
          id: 'id_comer',
          title: '1. COMER',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Incapaz'),
            QuestionOption(
              id: '2',
              label:
                  'Necesita ayuda para cortar, extender mantequilla, usar condimentos, etc.',
            ),
            QuestionOption(id: '3', label: 'Independiente: (puede comer solo)'),
          ],
        ),
        QuestionModel(
          id: 'id_traslado_silla_cama',
          title: '2. TRASLADARSE ENTRE LA SILLA Y LA CAMA',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Incapaz, no se mantiene sentado.'),
            QuestionOption(
              id: '2',
              label:
                  'Necesita ayuda importante (una persona entrenada o dos personas), puede estar sentado',
            ),
            QuestionOption(
              id: '3',
              label:
                  'Necesita algo de ayuda (una pequeña ayuda física o ayuda verbal)',
            ),
            QuestionOption(id: '4', label: 'Independiente'),
          ],
        ),
        QuestionModel(
          id: 'id_aseo_personal',
          title: '3. ASEO PERSONAL',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(
              id: '1',
              label: 'Necesita ayuda con el aseo personal',
            ),
            QuestionOption(
              id: '2',
              label:
                  'Independientemente para lavarse la cara, las manos y los dientes, peinarse y afeitarse',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_uso_retrete',
          title: '4. USO DEL RETRETE (ESCUSADO, INODORO)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Dependiente'),
            QuestionOption(
              id: '2',
              label: 'Necesita alguna ayuda, pero puede hacer algo solo',
            ),
            QuestionOption(
              id: '3',
              label: 'Independiente (entrenar y salir, limpiarse y vestirse)',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_baniarse',
          title: '5. BAÑARSE Y DUCHARSE',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Dependiente'),
            QuestionOption(
              id: '2',
              label: 'Independiente para bañarse y ducharse',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_desplazarse',
          title: '6. DESPLAZARSE',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Inmóvil'),
            QuestionOption(
              id: '2',
              label: 'Independientemente en silla de ruedas en 50 metros',
            ),
            QuestionOption(
              id: '3',
              label: 'Anda con pequeña ayuda de una persona (física o verbal)',
            ),
            QuestionOption(
              id: '4',
              label:
                  'Independientemente al menos 50 m con cualquier tipo de muleta excepto andador',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_subir_bajar_escaleras',
          title: '7. SUBIR Y BAJAR ESCALERAS',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Incapaz'),
            QuestionOption(
              id: '2',
              label:
                  'Necesita ayuda física y verbal puede llevar cualquier tipo de muleta',
            ),
            QuestionOption(
              id: '3',
              label: 'Independiente para subir y bajar escaleras',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_vestirse_desvestirse',
          title: '8. VESTIRSE O DESVESTIRSE',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(id: '1', label: 'Dependiente'),
            QuestionOption(
              id: '2',
              label:
                  'Necesita ayuda, pero puede hacer la mitad aproximadamente sin ayuda',
            ),
            QuestionOption(
              id: '3',
              label:
                  'Independientemente incluyendo botones, cremalleras (cierres) y cordones',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_control_heces',
          title: '9. CONTROL DE HECES',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(
              id: '1',
              label: 'Incontinente, (o necesita que le suministren enema)',
            ),
            QuestionOption(
              id: '2',
              label: 'Accidente excepcional (uno por semana)',
            ),
            QuestionOption(id: '3', label: 'Continente'),
          ],
        ),
        QuestionModel(
          id: 'id_control_orina',
          title: '10. CONTROL DE ORINA',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.indiceBarthel,
          options: [
            QuestionOption(
              id: '1',
              label: 'Incontinente o sondado incapaz de cambiarse la bolsa',
            ),
            QuestionOption(
              id: '2',
              label: 'Accidente excepcional (máximo uno en 24 horas)',
            ),
            QuestionOption(
              id: '3',
              label: 'Continente, durante al menos 7 días',
            ),
          ],
        ),

        // =========================
        // 8) Escala Lawton y Brody
        // =========================
        QuestionModel(
          id: 'id_capacidad_telefono',
          title: '1. CAPACIDAD PARA USAR TELÉFONO',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label: 'Utiliza el teléfono por iniciativa propia.',
            ),
            QuestionOption(
              id: '2',
              label: 'Es capaz de marcar bien algunos números familiares',
            ),
            QuestionOption(
              id: '3',
              label: 'Es capaz de contestar al teléfono, pero no de marcar.',
            ),
            QuestionOption(id: '4', label: 'No utiliza el teléfono'),
          ],
        ),
        QuestionModel(
          id: 'id_hacer_compras',
          title: '2. HACER COMPRAS',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label: 'Realiza todas las compras necesarias independientemente.',
            ),
            QuestionOption(
              id: '2',
              label: 'Realiza independientemente pequeñas compras.',
            ),
            QuestionOption(
              id: '3',
              label: 'Necesita ir acompañado para realizar cualquier compra.',
            ),
            QuestionOption(id: '4', label: 'Totalmente incapaz de comprar'),
          ],
        ),
        QuestionModel(
          id: 'id_preparar_comida',
          title: '3. PREPARACIÓN DE LA COMIDA',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label:
                  'Organiza, prepara y sirve las comidas por si solo adecuadamente.',
            ),
            QuestionOption(
              id: '2',
              label:
                  'Prepara adecuadamente las comidas si se le proporcionan los ingredientes',
            ),
            QuestionOption(
              id: '3',
              label:
                  'Prepara, calienta y sirve las comidas, pero no sigue una dieta adecuada.',
            ),
            QuestionOption(
              id: '4',
              label: 'Necesita que le preparen y le sirvan las comidas.',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_cuidado_casa',
          title: '4. CUIDADO DE LA CASA',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label:
                  'Mantiene la casa solo o con ayuda ocasional (para trabajos pesados).',
            ),
            QuestionOption(
              id: '2',
              label:
                  'Realiza tareas ligeras, como lavar los platos o hacer las camas.',
            ),
            QuestionOption(
              id: '3',
              label:
                  'Realiza tareas ligeras, pero no puede mantener un adecuado nivel de limpieza.',
            ),
            QuestionOption(
              id: '4',
              label: 'Necesita ayuda en todas las labores de la casa.',
            ),
            QuestionOption(
              id: '5',
              label: 'No participa en ninguna labor de la casa.',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_lavado_ropa',
          title: '5. LAVADO DE LA ROPA',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(id: '1', label: 'Lava por sí solo toda la ropa.'),
            QuestionOption(
              id: '2',
              label: 'Lava por si mismo pequeñas prendas.',
            ),
            QuestionOption(
              id: '3',
              label: 'Todo el lavado de ropa debe ser realizado por otro.',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_transporte',
          title: '6. USO DE MEDIOS DE TRANSPORTE',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label:
                  'Viaja solo en transporte público o conduce su propio coche.',
            ),
            QuestionOption(
              id: '2',
              label:
                  'Es capaz de coger un taxi, pero no usa otro medio de transporte.',
            ),
            QuestionOption(
              id: '3',
              label:
                  'Viaja en transporte público cuando va acompañado de otra persona.',
            ),
            QuestionOption(
              id: '4',
              label:
                  'Utiliza el taxi o el automóvil solo con la ayuda de otros.',
            ),
            QuestionOption(id: '5', label: 'No viaja'),
          ],
        ),
        QuestionModel(
          id: 'id_medicacion',
          title: '7. RESPONSABILIDAD RESPECTO A SU MEDICACIÓN',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label:
                  'Es capaz de tomar su medicación a la dosis y hora adecuada',
            ),
            QuestionOption(
              id: '2',
              label: 'Toma su medicación si la dosis es preparada previamente',
            ),
            QuestionOption(
              id: '3',
              label: 'No es capaz de administrarse su medicación.',
            ),
          ],
        ),
        QuestionModel(
          id: 'id_utilizar_dinero',
          title: '8. CAPACIDAD PARA UTILIZAR DINERO',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.lawtonBrody,
          options: [
            QuestionOption(
              id: '1',
              label: 'Se encarga de sus asuntos económicos por si solo',
            ),
            QuestionOption(
              id: '2',
              label:
                  'Realiza las compras de cada día, pero necesita ayuda con las grandes compras y en los bancos',
            ),
            QuestionOption(id: '3', label: 'Incapaz de manejar dinero.'),
          ],
        ),
        // -------------------------------------------------------------
        // MiniMental
        // -------------------------------------------------------------
        QuestionModel(
          id: 'id_tiempo_uno',
          title: '1. ¿En qué año estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_tiempo_dos',
          title: '2. ¿En qué estación estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_tiempo_tres',
          title: '3. ¿Qué día (número) es hoy?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_tiempo_cuatro',
          title: '4. ¿Qué mes es este?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_tiempo_cinco',
          title: '5. ¿Qué día de la semana es hoy?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_espacio_uno',
          title: '6. ¿En qué lugar estamos? (Hospital/Lugar)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_espacio_dos',
          title: '7. ¿En qué piso estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_espacio_tres',
          title: '8. ¿En qué ciudad estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_espacio_cuatro',
          title: '9. ¿En qué provincia estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_espacio_cinco',
          title: '10. ¿En qué país estamos?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_uno',
          title: '11. Repita: "PESETA" (o palabra equivalente)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_dos',
          title: '12. Repita: "CABALLO" (o palabra equivalente)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_tres',
          title: '13. Repita: "MANZANA" (o palabra equivalente)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_calculo_uno',
          title: '14. 30 - 3 = 27 (o 100-7=93)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_calculo_dos',
          title: '15. ... - 3 = 24 (o -7=86)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_calculo_tres',
          title: '16. ... - 3 = 21 (o -7=79)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_calculo_cuatro',
          title: '17. ... - 3 = 18 (o -7=72)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_calculo_cinco',
          title: '18. ... - 3 = 15 (o -7=65)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_dif_uno',
          title: '19. Recuerda: "PESETA"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_dif_dos',
          title: '20. Recuerda: "CABALLO"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_memoria_dif_tres',
          title: '21. Recuerda: "MANZANA"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_denominacion_uno',
          title: '22. Mostrar LAPIZ (o reloj): ¿Qué es?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_denominacion_dos',
          title: '23. Mostrar RELOJ (o lápiz): ¿Qué es?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_repeticion_uno',
          title: '24. Repita: "NI SÍ, NI NO, NI PERO" (o frase equiv.)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_comprension_uno',
          title: '25. Orden 1: "Coja un papel con la mano derecha"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_comprension_dos',
          title: '26. Orden 2: "Dóblelo por la mitad"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_comprension_tres',
          title: '27. Orden 3: "Póngalo en el suelo (o mesa)"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_lectura_uno',
          title: '28. Lea y ejecute: "CIERRE LOS OJOS"',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_escritura_uno',
          title: '29. Escriba una frase (sujeto y predicado)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_copia_uno',
          title: '30. Copie el dibujo (dos pentágonos cruzados)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.minimentalPam,
          options: [
            QuestionOption(id: '1', label: 'Correcto'),
            QuestionOption(id: '0', label: 'Incorrecto'),
          ],
        ),
        QuestionModel(
          id: 'id_yesavage_uno',
          title: '1. ¿Está básicamente satisfecho con su vida?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_dos',
          title: '2. ¿Ha renunciado a muchas de sus actividades e intereses?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_tres',
          title: '3. ¿Siente que su vida está vacía?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_cuatro',
          title: '4. ¿Se encuentra a menudo aburrido?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_cinco',
          title: '5. ¿La mayor parte del tiempo está de buen humor?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_seis',
          title: '6. ¿Teme que le pase algo malo?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_siete',
          title: '7. ¿Se siente feliz la mayor parte del tiempo?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_ocho',
          title: '8. ¿Se siente a menudo abandonado?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_nueve',
          title:
              '9. ¿Prefiere quedarse en casa en lugar de salir y hacer cosas?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_diez',
          title: '10. ¿Cree que tiene más problemas de memoria que la mayoría?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_once',
          title: '11. ¿Cree que vivir es maravilloso?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_doce',
          title: '12. ¿Le cuesta iniciar nuevos proyectos?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_trece',
          title: '13. ¿Se siente lleno de energía?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_catorce',
          title: '14. ¿Siente que su situación es desesperada?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        QuestionModel(
          id: 'id_yesavage_quince',
          title: '15. ¿Cree que la mayoría de la gente está mejor que usted?',
          type: QuestionType.yesNo,
          required: false,
          section: SurveySection.yesavagePam,
        ),
        // FICHA DE DISCAPACIDADES
        //PONER ENCABEZADO
        QuestionModel(
          id: 'idAtenMedD',
          title: '1. ¿Recibe atención médica adecuada y adaptada a sus necesidades? (Bienestar fisico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idRecursosSufD',
          title: '2. ¿Cuenta  con recursos económicos suficientes para cubrir sus necesidades básicas? (Bienestar material)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idApoyoEmocD',
          title: '3. ¿Tiene apoyo emocional frente a los retos que enfrenta por su discapacidad? (Biestar emocional)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idRedApoyoD',
          title: '4. ¿Cuenta con una red de apoyo y vínculos significativos para realizar sus actividades? (Bienestar inclusion social)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idOportFormProfD',
          title: '5. ¿Ha tenido oportunidades de formación profesional o educativa adaptada? (Desrechos /inclusión social)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idDecisVidaD',
          title: '6. ¿Participa en decisiones sobre su vida cotidiana? (autoderminación)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idOportunEmpleoD',
          title: '7. ¿Tiene oportunidades de empleo o actividades productivas? (Bienestar material)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAccesInfoDereD',
          title: '8. ¿Tiene acceso la persona a información comprensible sobre sus derechos? (derechos)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idNoVolDecisD',
          title: '9. ¿Otras personas deciden por ella / el sin intentar comprender su voluntad?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idParticipaEntorD',
          title: '10. ¿Participa en entornos educativos, laborales o comunitarios sin barreras? (Desarrollo personal)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idSinApoyoD',
          title: '11. ¿Se ha sentido desbordado/a emocionalmente sin apoyo? (Binestar emocional)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAccederObstD',
          title: '12. ¿Puede acceder sin obstáculos a lugares públicos y privados? (Inclusión social / Bienestar físico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idExpresarOpinD',
          title: '13.	¿Puede expresar sus opiniones y que estas sean respetadas? (autoderminación)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idApoyoDesaHabilD',
          title: '14.	¿Recibe los apoyos necesarios para desarrollar sus habilidades?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idDiscrimViolenciaD',
          title: '15.	¿Se ha vuelto inmerso en situaciones de discriminación o violencia de sus derechos por su condición?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idIntitutoAprenderD',
          title: '16.	¿Vas a la un instituto, taller o centro donde aprendes cosas nuevas? (Desarrollo Personal)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idCondicMinimSegD',
          title: '17.	¿Su vivienda cuenta con condiciones mínimas adecuadas de seguridad y accesibilidad? (rampas, baños adaptados, espacios seguros)?  Bienestar material ',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD INTELECTUAL DE TÍTULO
        QuestionModel(
          id: 'idEnseUtiliMatD',
          title: '18. ¿Te enseñan de una forma que entiendes utilizando materiales de lectura facil, pictogramas, entre otros? (Desarrollo personal)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idApoyoDecisVidaD',
          title: '19. ¿Recibe apoyo para tomar decisiones importantes en su vida diaria?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idValOpinionesD',
          title: '20. ¿Siente que son tomadas en cuenta y valoradas su opiniones?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD VISUAL DE TÍTULO
        QuestionModel(
          id: 'idEnseFormaAccesD',
          title: '21. ¿Te enseñan utilizando materiales en formatos accesibles (braille, audio, macrotipo o lectores de pantalla. etc.)? (Derechos / Desarrollo personal)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idSegComuniD',
          title: '22. ¿Puede desplazarse seguro por su comunidad? (Bienestar físico / Inclusión social)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAyudaTecnicD',
          title: '23. ¿Cuenta con ayudas técnicas (bastón blanco, lector de pantalla, lupa, etc.) en buen estado?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD AUDITIVA DE TÍTULO
        QuestionModel(
          id: 'idApoyoDialogD',
          title: '24. ¿Cuenta con apoyos para entender diálogos o escritos como: interpretación  de lengua de señas, subtitulación en contextos públicos? (Derechos / Inclusión social)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAudifAyuTecD',
          title: '25. ¿Cuenta con audífonos, implante coclear u otras ayudas técnicas en buen estado ? (Bienestar físico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idMantAyuTecD',
          title: '26. ¿Recibe apoyo para la reposición o mantenimiento de estas ayudas tecnicas que utliliza?(Bienestar físico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD FÍSICA O MOTORA TÍTULO
        QuestionModel(
          id: 'idAyuTecBuenEstD',
          title: '27. ¿Cuenta con ayudas técnicas (silla de ruedas, muletas, prótesis, órtesis, etc.) en buen estado?',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAyuTecMovMasD',
          title: '28. ¿Usa más de una ayuda técnica para su movilidad? (Bienestar físico / Derechos)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idMedDifMovD',
          title: '29. ¿Ha dejado de asistir a controles médicos o terapias por dificultades de movilidad o accesibilidad? (bienestar fisico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD PSICOSOCIAL TÍTULO
        QuestionModel(
          id: 'idApoyoPsicoD',
          title: '30. ¿Requiere de apoyo psicológico o psiquiátrico permanente? (Bienestar emocional / Bienestar físico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idNoAsisteTratD',
          title: '31. ¿Ha dejado de asistir a citas o tratamientos por barreras económicas, sociales o de estigmatización? (Bienestar físico)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAccesContrMentalD',
          title: '32. ¿Tiene acceso regular y continuo a servicios de salud mental o cuando lo necesita? Bienestar físico',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD MÚLTIPLE TÍTULO
        QuestionModel(
          id: 'idEntornoAdaptadoD',
          title: '33. Su entorno (hogar, centro, comunidad) está adaptado a sus necesidades? (Inclusión social / Bienestar material)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idBienestarSeniaD',
          title: '34. ¿La persona muestra señales de bienestar (tranquilidad, sonrisa, relajación) cuando está en compañía o en su rutina diaria? (Bienestar emocional)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idExprDeciPrefD',
          title: '35. ¿Puede la persona expresar (de forma verbal, gestual o asistida) sus preferencias o decisiones? (Autodeterminación / Desarrollo personal)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //FALTA DISCAPACIDAD DE LENGUAJE TÍTULO
        QuestionModel(
          id: 'idAccesTerapiasD',
          title: '36. ¿Cuenta con acceso a terapias de lenguaje u otros apoyos especializados? (Bienestar Material)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idExclActD',
          title: '37. ¿Ha sido excluida/o de actividades por su dificultad de lenguaje? (inclusion social)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        QuestionModel(
          id: 'idAyuTecComD',
          title: '38. ¿Dispone de materiales o ayudas técnicas para la comunicación (pictogramas, dispositivos, cuadernos)? (Inclusión docial / Bienestar material)',
          type: QuestionType.singleChoice,
          required: false,
          section: SurveySection.fichaPcd,
          options: [
            QuestionOption(id: '1', label: 'Sí'),
            QuestionOption(id: '2', label: 'No'),
            QuestionOption(id: '3', label: 'A veces'),
          ],
        ),
        //SECCIÓN BAREMO

      ],
    );
    return [survey];
  }
}
