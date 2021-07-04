import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/weekday.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/report_consolidate_model.dart';

class ModalReport extends StatefulWidget {
  ModalReport({this.items});

  final List<ReportConsolidateModel> items;

  @override
  _ModalReportState createState() => _ModalReportState();
}

class _ModalReportState extends State<ModalReport> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: constraints.maxHeight),
        child: SingleChildScrollView(
          child: AlertDialog(
              backgroundColor: Colors.grey.shade100,
              elevation: 4,
              title: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colours.Purple),
                  height: 30,
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            "Frequência de Colaboradores",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: SizedBox(
                              child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                        )
                      ],
                    ),
                  )),
              titlePadding: EdgeInsets.all(0),
              content: Container(
                height: constraints.maxHeight * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.2,
                            color: Colours.Blue,
                            child: Text(
                              "Sessão",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.12,
                            color: Colours.Blue,
                            child: Text(
                              "Data",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.12,
                            color: Colours.Blue,
                            child: Text(
                              "Dia da semana",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.08,
                            color: Colours.Blue,
                            child: Text(
                              "Início",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.08,
                            color: Colours.Blue,
                            child: Text(
                              "Fim",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: constraints.maxWidth * 0.1,
                            color: Colours.Blue,
                            child: Text(
                              "Participantes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.03),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      Column(
                          children: List.generate(widget.items.length, (index) {
                        return Column(
                          children: [
                            SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.2,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    widget.items[index].description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            constraints.maxHeight * 0.025),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.12,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    formatDate(widget.items[index].sessionDate,
                                        [dd, '/', mm, '/', yyyy]),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            constraints.maxHeight * 0.025),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.12,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    WeekDay.getWeekDayName(
                                        widget.items[index].weekDay),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            constraints.maxHeight * 0.025),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.08,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    widget.items[index].startSession,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            constraints.maxHeight * 0.025),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.08,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    widget.items[index].endSession,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            constraints.maxHeight * 0.025),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: constraints.maxWidth * 0.1,
                                  color: Colors.grey.shade300,
                                  child: Text(
                                    widget.items[index].countAccess.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxHeight * 0.03),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ],
                        );
                      }))
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}
