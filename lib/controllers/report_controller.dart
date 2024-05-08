import 'dart:convert';

import 'package:br_com_mindselfcompany_backoffice_web/dto/report_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/report_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_courses_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_employess_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_session_timer_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:universal_html/html.dart';

import '../constants/form_key.dart';

class ReportController extends GetxController {
  @protected
  final ReportRepository reportRepository;

  List<ReportSessionTimerModel>? reportSessionTimer =
      <ReportSessionTimerModel>[].obs;
  List<ReportCoursesModel>? reportCoursesData = <ReportCoursesModel>[].obs;
  List<ReportEmployeesModel>? reportEmployessData =
      <ReportEmployeesModel>[].obs;

  ReportController(this.reportRepository);

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  var _groupReport = 1000.obs;
  int get groupReport => _groupReport.value;
  set groupReport(value) => _groupReport.value = value;

  var _isValidReport = true.obs;
  bool get isValidReport => _isValidReport.value;
  set isValidReport(value) => _isValidReport.value = value;

  var _isValidPeriod = true.obs;
  bool get isValidPeriod => _isValidPeriod.value;
  set isValidPeriod(value) => _isValidPeriod.value = value;

  var _messagePeriod = "".obs;
  String get messagePeriod => _messagePeriod.value;
  set messagePeriod(value) => _messagePeriod.value = value;

  final TextEditingController initialDateController =
      new TextEditingController();
  final TextEditingController finalDateController = new TextEditingController();

  final MaskTextInputFormatter formatter =
      MaskTextInputFormatter(mask: "##/##/####");

  Future<ApiResultModel<bool>> getSessionTimerReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportSessionTimerModel>> result =
        await reportRepository.getReportSessionAndTimer(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportSessionTimer = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future<ApiResultModel<bool>> getCoursesReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportCoursesModel>> result =
        await reportRepository.getReportCourses(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportCoursesData = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future<ApiResultModel<bool>> getEmployessReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportEmployeesModel>> result =
        await reportRepository.getReportEmployees(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportEmployessData = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future<void> doReport() async {
    bool saveData = true;
    var _initialDate = DateTime.now();

    var _finalDate = DateTime.now();

    if (!FormKey.key.currentState!.validate()) saveData = false;

    isValidPeriod = true;
    isValidReport = true;

    if (groupReport == 1000) {
      isValidReport = false;
      saveData = false;
    }

    if (initialDateController.text.trim() == "" && saveData) {
      isValidPeriod = false;
      messagePeriod = "Favor preencher a data inicial.";
      saveData = false;
    }

    if (finalDateController.text.trim() == "" && saveData) {
      isValidPeriod = false;
      messagePeriod = "Favor preencher a data final.";
      saveData = false;
    }

    if (saveData) {
      var initialDate = initialDateController.text.split('/');
      var finalDate = finalDateController.text.split('/');

      if (formatDate(
                  DateTime(
                      int.tryParse(initialDate[2])!,
                      int.tryParse(initialDate[1])!,
                      int.tryParse(initialDate[0])!),
                  [dd, '/', mm, '/', yyyy]) !=
              initialDateController.text &&
          saveData) {
        isValidPeriod = false;
        messagePeriod = "Data inicial inválida.";
        saveData = false;
      }

      if (formatDate(
                  DateTime(int.tryParse(finalDate[2])!,
                      int.tryParse(finalDate[1])!, int.tryParse(finalDate[0])!),
                  [dd, '/', mm, '/', yyyy]) !=
              finalDateController.text &&
          saveData) {
        isValidPeriod = false;
        messagePeriod = "Data final inválida.";
        saveData = false;
      }

      _initialDate = DateTime(int.tryParse(initialDate[2])!,
          int.tryParse(initialDate[1])!, int.tryParse(initialDate[0])!);

      _finalDate = DateTime(int.tryParse(finalDate[2])!,
          int.tryParse(finalDate[1])!, int.tryParse(finalDate[0])!);

      if (_initialDate.isAfter(_finalDate)) {
        isValidPeriod = false;
        messagePeriod = "Data inicial está superior a data final.";
        saveData = false;
      }

      if (_finalDate.difference(_initialDate).inDays > 366) {
        isValidPeriod = false;
        messagePeriod = "A data de pesquisa não pode ser superior a 365 dias.";
        saveData = false;
      }
    }

    if (saveData) {
      ApiResultModel result = await (groupReport == 0
          ? getSessionTimerReport(_initialDate, _finalDate)
          : (groupReport == 1
              ? getCoursesReport(_initialDate, _finalDate)
              : getEmployessReport(_initialDate, _finalDate)));

      if (result.message!.isEmpty) {
        await _openReport();
      } else {
        Get.snackbar(
          "ERRO",
          result.message!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      }
    }
  }

  Future _openReport() async {
    String header = "";
    List<String> lines = [];
    String reportName = "";

    switch (groupReport) {
      case 0:
        header =
            "id_empresa;empresa;id_colaborador;colaborador;email;quebra1;quebra2;identificação;menu;id_tempo;tempo;id_tipo;tipo_atividade;id_midia;nome_midia;tipo_midia;hora_inicio;hora_final;id_emocional;emocional;id_progresso;progresso;ano;mes;dia;dia_semana;periodo;mesano";
        reportName = "MeDiT_Sessoes_Timers_";
        lines = _generateLinesSessionTimer(reportSessionTimer!);
        break;

      case 1:
        header =
            "id_empresa;empresa;id_colaborador;colaborador;email;quebra1;quebra2;identificação;id_curso;curso;id_semana;semana;id_aula;aula;id_midia;nome_midia;tipo_midia;hora_inicio;hora_final;id_emocional;emocional;id_progresso;progresso;ano;mes;dia;dia_semana;periodo;mesano";
        reportName = "MeDiT_Cursos_";
        lines = _generateLinesCourses(reportCoursesData!);
        break;

      case 2:
        header =
            "id_company;empresa;id_employee;colaborador;email;quebra1;quebra2;identificação;dt_ativacao;ano;mes;dia;mesano";
        reportName = "MeDiT_Colaboradores_";
        lines = _generateLinesEmployees(reportEmployessData!);
        break;
    }

    lines.insert(0, header);

    AnchorElement()
      ..href =
          '${Uri.dataFromString(lines.join("\r\n"), mimeType: 'text/csv', encoding: Encoding.getByName("ISO-8859-1"))}'
      ..download = reportName +
          initialDateController.text.replaceAll("/", "") +
          "_" +
          finalDateController.text.replaceAll("/", "") +
          ".csv"
      ..style.display = 'none'
      ..click();
  }

  List<String> _generateLinesSessionTimer(List<ReportSessionTimerModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idEmpresa.toString() +
          ";" +
          e.empresa! +
          ";" +
          e.idColaborador.toString() +
          ";" +
          e.colaborador! +
          ";" +
          e.email! +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2! +
          ";" +
          e.matricula +
          ";" +
          e.menu! +
          ";" +
          e.idTempo.toString() +
          ";" +
          e.tempo! +
          ";" +
          e.idTipo.toString() +
          ";" +
          e.tipoAtividade! +
          ";" +
          e.idMidia.toString() +
          ";" +
          e.nomeMidia! +
          ";" +
          e.tipoMidia! +
          ";" +
          formatDate(e.horaInicio!,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          formatDate(e.horaFinal!,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          e.idEmocional.toString() +
          ";" +
          e.emocional! +
          ";" +
          e.idProgresso! +
          ";" +
          e.progresso! +
          ";" +
          e.ano.toString() +
          ";" +
          e.mes.toString() +
          ";" +
          e.dia.toString() +
          ";" +
          e.diaSemana! +
          ";" +
          e.periodo! +
          ";" +
          e.mesano!);
    });

    return lines;
  }

  List<String> _generateLinesCourses(List<ReportCoursesModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idEmpresa.toString() +
          ";" +
          e.empresa! +
          ";" +
          e.idColaborador.toString() +
          ";" +
          e.colaborador! +
          ";" +
          e.email! +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2! +
          ";" +
          e.matricula +
          ";" +
          e.idCurso.toString() +
          ";" +
          e.curso! +
          ";" +
          e.idSemana.toString() +
          ";" +
          e.semana! +
          ";" +
          e.idAula.toString() +
          ";" +
          e.aula! +
          ";" +
          e.idMidia.toString() +
          ";" +
          e.nomeMidia! +
          ";" +
          e.tipoMidia! +
          ";" +
          formatDate(e.horaInicio!,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          formatDate(e.horaFinal!,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          e.idEmocional.toString() +
          ";" +
          e.emocional! +
          ";" +
          e.idProgresso! +
          ";" +
          e.progresso! +
          ";" +
          e.ano.toString() +
          ";" +
          e.mes.toString() +
          ";" +
          e.dia.toString() +
          ";" +
          e.diaSemana! +
          ";" +
          e.periodo! +
          ";" +
          e.mesano!);
    });

    return lines;
  }

  List<String> _generateLinesEmployees(List<ReportEmployeesModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idCompany.toString() +
          ";" +
          e.empresa! +
          ";" +
          e.idEmployee.toString() +
          ";" +
          e.colaborador! +
          ";" +
          e.email! +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2 +
          ";" +
          e.matricula! +
          ";" +
          formatDate(e.dtAtivacao!,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          e.ano.toString() +
          ";" +
          e.mes.toString() +
          ";" +
          e.dia.toString() +
          ";" +
          e.mesano.toString());
    });

    return lines;
  }

  Future<void> redirectHome() async {
    await Get.offAllNamed("/home", arguments: {"acao": "C", "idScreen": 2});
  }
}
