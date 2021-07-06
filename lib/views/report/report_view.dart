import 'dart:convert';

import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_courses_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_employess_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_session_timer_model.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/report_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/report_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:universal_html/html.dart';

class Report extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _initialDateController =
      new TextEditingController();
  final TextEditingController _finalDateController =
      new TextEditingController();

  final MaskTextInputFormatter _formatter =
      MaskTextInputFormatter(mask: "##/##/####");

  Future _openReport(ReportController _) async {
    String header = "";
    List<String> lines = [];
    String reportName = "";

    switch (_.groupReport) {
      case 0:
        header =
            "id_empresa;empresa;id_colaborador;colaborador;email;quebra1;quebra2;identificação;menu;id_tempo;tempo;id_tipo;tipo_atividade;id_midia;nome_midia;tipo_midia;hora_inicio;hora_final;id_emocional;emocional;id_progresso;progresso;ano;mes;dia;dia_semana;periodo;mesano";
        reportName = "MeDiT_Sessoes_Timers_";
        lines = _generateLinesSessionTimer(_.reportSessionTimer);
        break;

      case 1:
        header =
            "id_empresa;empresa;id_colaborador;colaborador;email;quebra1;quebra2;identificação;id_curso;curso;id_semana;semana;id_aula;aula;id_midia;nome_midia;tipo_midia;hora_inicio;hora_final;id_emocional;emocional;id_progresso;progresso;ano;mes;dia;dia_semana;periodo;mesano";
        reportName = "MeDiT_Cursos_";
        lines = _generateLinesCourses(_.reportCoursesData);
        break;

      case 2:
        header =
            "id_company;empresa;id_employee;colaborador;email;quebra1;quebra2;identificação;dt_ativacao;ano;mes;dia;mesano";
        reportName = "MeDiT_Colaboradores_";
        lines = _generateLinesEmployees(_.reportEmployessData);
        break;
    }

    lines.insert(0, header);

    AnchorElement()
      ..href =
          '${Uri.dataFromString(lines.join("\r\n"), mimeType: 'text/csv', encoding: Encoding.getByName("ISO-8859-1"))}'
      ..download = reportName +
          _initialDateController.text.replaceAll("/", "") +
          "_" +
          _finalDateController.text.replaceAll("/", "") +
          ".csv"
      ..style.display = 'none'
      ..click();
  }

  List<String> _generateLinesSessionTimer(List<ReportSessionTimerModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idEmpresa.toString() +
          ";" +
          e.empresa +
          ";" +
          e.idColaborador.toString() +
          ";" +
          e.colaborador +
          ";" +
          e.email +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2 +
          ";" +
          e.matricula +
          ";" +
          e.menu +
          ";" +
          e.idTempo.toString() +
          ";" +
          e.tempo +
          ";" +
          e.idTipo.toString() +
          ";" +
          e.tipoAtividade +
          ";" +
          e.idMidia.toString() +
          ";" +
          e.nomeMidia +
          ";" +
          e.tipoMidia +
          ";" +
          formatDate(e.horaInicio,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          formatDate(e.horaFinal,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          e.idEmocional.toString() +
          ";" +
          e.emocional +
          ";" +
          e.idProgresso +
          ";" +
          e.progresso +
          ";" +
          e.ano.toString() +
          ";" +
          e.mes.toString() +
          ";" +
          e.dia.toString() +
          ";" +
          e.diaSemana +
          ";" +
          e.periodo +
          ";" +
          e.mesano);
    });

    return lines;
  }

  List<String> _generateLinesCourses(List<ReportCoursesModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idEmpresa.toString() +
          ";" +
          e.empresa +
          ";" +
          e.idColaborador.toString() +
          ";" +
          e.colaborador +
          ";" +
          e.email +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2 +
          ";" +
          e.matricula +
          ";" +
          e.idCurso.toString() +
          ";" +
          e.curso +
          ";" +
          e.idSemana.toString() +
          ";" +
          e.semana +
          ";" +
          e.idAula.toString() +
          ";" +
          e.aula +
          ";" +
          e.idMidia.toString() +
          ";" +
          e.nomeMidia +
          ";" +
          e.tipoMidia +
          ";" +
          formatDate(e.horaInicio,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          formatDate(e.horaFinal,
              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]) +
          ";" +
          e.idEmocional.toString() +
          ";" +
          e.emocional +
          ";" +
          e.idProgresso +
          ";" +
          e.progresso +
          ";" +
          e.ano.toString() +
          ";" +
          e.mes.toString() +
          ";" +
          e.dia.toString() +
          ";" +
          e.diaSemana +
          ";" +
          e.periodo +
          ";" +
          e.mesano);
    });

    return lines;
  }

  List<String> _generateLinesEmployees(List<ReportEmployeesModel> lst) {
    List<String> lines = [];

    lst.forEach((e) {
      lines.add(e.idCompany.toString() +
          ";" +
          e.empresa +
          ";" +
          e.idEmployee.toString() +
          ";" +
          e.colaborador +
          ";" +
          e.email +
          ";" +
          e.quebra1 +
          ";" +
          e.quebra2 +
          ";" +
          e.matricula +
          ";" +
          formatDate(e.dtAtivacao,
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

  Future<void> _sendValues(ReportController _) async {
    bool saveData = true;
    var _initialDate = DateTime.now();

    var _finalDate = DateTime.now();

    if (!_formKey.currentState.validate()) saveData = false;

    _.isValidPeriod = true;
    _.isValidReport = true;

    if (_.groupReport == 1000) {
      _.isValidReport = false;
      saveData = false;
    }

    if (_initialDateController.text.trim() == "" && saveData) {
      _.isValidPeriod = false;
      _.messagePeriod = "Favor preencher a data inicial.";
      saveData = false;
    }

    if (_finalDateController.text.trim() == "" && saveData) {
      _.isValidPeriod = false;
      _.messagePeriod = "Favor preencher a data final.";
      saveData = false;
    }

    if (saveData) {
      var initialDate = _initialDateController.text.split('/');
      var finalDate = _finalDateController.text.split('/');

      if (formatDate(
                  DateTime(
                      int.tryParse(initialDate[2]),
                      int.tryParse(initialDate[1]),
                      int.tryParse(initialDate[0])),
                  [dd, '/', mm, '/', yyyy]) !=
              _initialDateController.text &&
          saveData) {
        _.isValidPeriod = false;
        _.messagePeriod = "Data inicial inválida.";
        saveData = false;
      }

      if (formatDate(
                  DateTime(int.tryParse(finalDate[2]),
                      int.tryParse(finalDate[1]), int.tryParse(finalDate[0])),
                  [dd, '/', mm, '/', yyyy]) !=
              _finalDateController.text &&
          saveData) {
        _.isValidPeriod = false;
        _.messagePeriod = "Data final inválida.";
        saveData = false;
      }

      _initialDate = DateTime(int.tryParse(initialDate[2]),
          int.tryParse(initialDate[1]), int.tryParse(initialDate[0]));

      _finalDate = DateTime(int.tryParse(finalDate[2]),
          int.tryParse(finalDate[1]), int.tryParse(finalDate[0]));

      if (_initialDate.isAfter(_finalDate)) {
        _.isValidPeriod = false;
        _.messagePeriod = "Data inicial está superior a data final.";
        saveData = false;
      }

      if (_finalDate.difference(_initialDate).inDays > 360) {
        _.isValidPeriod = false;
        _.messagePeriod =
            "A data de pesquisa não pode ser superior a 360 dias.";
        saveData = false;
      }
    }

    if (saveData) {
      ApiResultModel result = await (_.groupReport == 0
          ? _.getSessionTimerReport(_initialDate, _finalDate)
          : (_.groupReport == 1
              ? _.getCoursesReport(_initialDate, _finalDate)
              : _.getEmployessReport(_initialDate, _finalDate)));

      if (result.message.isEmpty) {
        _openReport(_);
      } else {
        Get.snackbar(
          "ERRO",
          result.message,
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

  Future _redirect() async {
    await Get.delete<ReportController>();
    await Get.offAllNamed("/home", arguments: [0]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _redirect();
      },
      child: Scaffold(
        bottomNavigationBar: BottomPage(
          margin: 80,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colours.Purple,
          title: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.arrow_back,
                    size: MediaQuery.of(context).size.width * 0.025,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await _redirect();
                  },
                ),
                Expanded(
                  child: Text(
                    "Relatórios",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
        ),
        body: GetX<ReportController>(
            init: ReportController(Get.find<ReportRepository>()),
            dispose: (_) {
              _initialDateController.clear();
              _finalDateController.clear();
            },
            builder: (_) {
              if (_.isLoading) return Load();

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                      margin: EdgeInsets.only(left: 60),
                      height: constraints.maxHeight,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                        top: 5, left: 20, right: 5),
                                    width: constraints.maxWidth - 67,
                                    child: InputDecorator(
                                      decoration: new InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.Purple)),
                                        focusColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        fillColor: Colors.grey.shade200,
                                        errorStyle: TextStyle(
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color(0x22000000),
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'TIPO DO RELATÓRIO:',
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                            color: Colours.Blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Container(
                                        width: constraints.maxWidth * 0.7,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                  width:
                                                      constraints.maxWidth / 4,
                                                  child: Obx(
                                                    () => RadioListTile(
                                                      activeColor:
                                                          Colours.Green,
                                                      groupValue: _.groupReport,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      title: Text(
                                                          "SESSÕES GUIADAS E TIMER",
                                                          style: TextStyle(
                                                              fontSize: constraints
                                                                      .maxWidth *
                                                                  0.01)),
                                                      value: 0,
                                                      onChanged: (val) {
                                                        _.groupReport = val;
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            Flexible(
                                              child: Container(
                                                  width:
                                                      constraints.maxWidth / 4,
                                                  child: Obx(
                                                    () => RadioListTile(
                                                      activeColor:
                                                          Colours.Green,
                                                      groupValue: _.groupReport,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      title: Text("CURSOS",
                                                          style: TextStyle(
                                                              fontSize: constraints
                                                                      .maxWidth *
                                                                  0.01)),
                                                      value: 1,
                                                      onChanged: (val) {
                                                        _.groupReport = val;
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            Flexible(
                                              child: Container(
                                                  width:
                                                      constraints.maxWidth / 4,
                                                  child: Obx(
                                                    () => RadioListTile(
                                                      activeColor:
                                                          Colours.Green,
                                                      groupValue: _.groupReport,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      title: Text(
                                                          "USUÁRIOS ATIVOS",
                                                          style: TextStyle(
                                                              fontSize: constraints
                                                                      .maxWidth *
                                                                  0.01)),
                                                      value: 2,
                                                      onChanged: (val) {
                                                        _.groupReport = val;
                                                      },
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return _.isValidReport
                                        ? SizedBox()
                                        : Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Favor selecionar o tipo de relatório.",
                                                style: TextStyle(
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.03,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colours.BlueAccented),
                                              ),
                                            ));
                                  }),
                                  Flexible(
                                    child: SizedBox(
                                      height: 15,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: InputDecorator(
                                      decoration: new InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.Purple)),
                                        focusColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        fillColor: Colors.grey.shade200,
                                        errorStyle: TextStyle(
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color(0x22000000),
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText:
                                            'DATAS DE APURAÇÃO: (Máximo de 360 dias)',
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                            color: Colours.Blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: Container(
                                        width: constraints.maxWidth * 0.7,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Text(
                                                  "Inicial:",
                                                  style: TextStyle(
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.03,
                                                    color: Colours.Blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: TextFormField(
                                                  inputFormatters: [_formatter],
                                                  cursorColor: Colors.black,
                                                  controller:
                                                      _initialDateController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusColor: Colors.black,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    hintText: formatDate(
                                                        DateTime.now(), [
                                                      dd,
                                                      '/',
                                                      mm,
                                                      '/',
                                                      yyyy
                                                    ]),
                                                    hintStyle: TextStyle(
                                                      fontSize: constraints
                                                              .maxHeight *
                                                          0.03,
                                                    ),
                                                    labelStyle: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        color: Colours.Blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Text(
                                                  "Final:",
                                                  style: TextStyle(
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.03,
                                                    color: Colours.Blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: TextFormField(
                                                  inputFormatters: [_formatter],
                                                  cursorColor: Colors.black,
                                                  controller:
                                                      _finalDateController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusColor: Colors.black,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                    hintText: formatDate(
                                                        DateTime.now().add(
                                                            Duration(days: 30)),
                                                        [
                                                          dd,
                                                          '/',
                                                          mm,
                                                          '/',
                                                          yyyy
                                                        ]),
                                                    hintStyle: TextStyle(
                                                      fontSize: constraints
                                                              .maxHeight *
                                                          0.03,
                                                    ),
                                                    labelStyle: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        color: Colours.Blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return _.isValidPeriod
                                        ? SizedBox(height: 20)
                                        : Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                _.messagePeriod,
                                                style: TextStyle(
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.03,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        Colours.BlueAccented),
                                              ),
                                            ));
                                  }),
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty
                                                  .resolveWith((states) => Size(
                                                      constraints.maxWidth *
                                                          0.2,
                                                      constraints.maxHeight *
                                                          0.08)),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Colours.BlueAccented),
                                            ),
                                            onPressed: () async {
                                              await _sendValues(_);
                                            },
                                            child: Text(
                                              "GERAR",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.03),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              );
            }),
      ),
    );
  }
}
