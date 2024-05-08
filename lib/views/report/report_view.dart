import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/report_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/form_key.dart';

class Report extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (didPop) async => await controller.redirectHome(),
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
                        await controller.redirectHome();
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
            body: Obx(() => controller.isLoading.isTrue
                ? Load()
                : LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                          margin: EdgeInsets.only(left: 60),
                          height: constraints.maxHeight,
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: IntrinsicHeight(
                                child: Form(
                                  key: FormKey.key,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
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
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            fillColor: Colors.grey.shade200,
                                            errorStyle: TextStyle(
                                              color: Colours.BlueAccented,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor:
                                                  Color(0x22000000),
                                            ),
                                            errorMaxLines: 2,
                                            filled: true,
                                            labelText: 'TIPO DO RELATÓRIO:',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      child: Obx(
                                                        () => RadioListTile(
                                                          activeColor:
                                                              Colours.Green,
                                                          groupValue: controller
                                                              .groupReport,
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Text(
                                                              "SESSÕES GUIADAS E TIMER",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxWidth *
                                                                          0.01)),
                                                          value: 0,
                                                          onChanged:
                                                              (dynamic val) {
                                                            controller
                                                                    .groupReport =
                                                                val;
                                                          },
                                                        ),
                                                      )),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      child: Obx(
                                                        () => RadioListTile(
                                                          activeColor:
                                                              Colours.Green,
                                                          groupValue: controller
                                                              .groupReport,
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Text("CURSOS",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxWidth *
                                                                          0.01)),
                                                          value: 1,
                                                          onChanged:
                                                              (dynamic val) {
                                                            controller
                                                                    .groupReport =
                                                                val;
                                                          },
                                                        ),
                                                      )),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                      width:
                                                          constraints.maxWidth /
                                                              4,
                                                      child: Obx(
                                                        () => RadioListTile(
                                                          activeColor:
                                                              Colours.Green,
                                                          groupValue: controller
                                                              .groupReport,
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          title: Text(
                                                              "USUÁRIOS ATIVOS",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      constraints
                                                                              .maxWidth *
                                                                          0.01)),
                                                          value: 2,
                                                          onChanged:
                                                              (dynamic val) {
                                                            controller
                                                                    .groupReport =
                                                                val;
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
                                        return controller.isValidReport
                                            ? SizedBox()
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 8.0),
                                                  child: Text(
                                                    "Favor selecionar o tipo de relatório.",
                                                    style: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colours
                                                            .BlueAccented),
                                                  ),
                                                ));
                                      }),
                                      Flexible(
                                        child: SizedBox(
                                          height: 15,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
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
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            fillColor: Colors.grey.shade200,
                                            errorStyle: TextStyle(
                                              color: Colours.BlueAccented,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor:
                                                  Color(0x22000000),
                                            ),
                                            errorMaxLines: 2,
                                            filled: true,
                                            labelText:
                                                'DATAS DE APURAÇÃO: (Máximo de 360 dias)',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text(
                                                      "Inicial:",
                                                      style: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        color: Colours.Blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        controller.formatter
                                                      ],
                                                      cursorColor: Colors.black,
                                                      controller: controller
                                                          .initialDateController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusColor:
                                                            Colors.black,
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
                                                                FontWeight
                                                                    .bold),
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
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        color: Colours.Blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        controller.formatter
                                                      ],
                                                      cursorColor: Colors.black,
                                                      controller: controller
                                                          .finalDateController,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusColor:
                                                            Colors.black,
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .always,
                                                        hintText: formatDate(
                                                            DateTime.now().add(
                                                                Duration(
                                                                    days: 30)),
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
                                                                FontWeight
                                                                    .bold),
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
                                        return controller.isValidPeriod
                                            ? SizedBox(height: 20)
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(left: 20),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 8.0),
                                                  child: Text(
                                                    controller.messagePeriod,
                                                    style: TextStyle(
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colours
                                                            .BlueAccented),
                                                  ),
                                                ));
                                      }),
                                      SizedBox(
                                        width: constraints.maxWidth,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 20),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  minimumSize: MaterialStateProperty
                                                      .resolveWith((states) =>
                                                          Size(
                                                              constraints
                                                                      .maxWidth *
                                                                  0.2,
                                                              constraints
                                                                      .maxHeight *
                                                                  0.08)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colours.BlueAccented),
                                                ),
                                                onPressed: () async {
                                                  await controller.doReport();
                                                },
                                                child: Text(
                                                  "GERAR",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: constraints
                                                              .maxHeight *
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
                  ))));
  }
}
