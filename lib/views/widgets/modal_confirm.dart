import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';

class ModalConfirm extends StatelessWidget {
  final String? title;
  final String? text;

  const ModalConfirm({Key? key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: constraints.maxHeight),
        child: SingleChildScrollView(
          child: AlertDialog(
              elevation: 4,
              title: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colours.Purple),
                  height: 30,
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              titlePadding: EdgeInsets.all(0),
              content: Container(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colours.BlueAccented)),
                          child: Text('CONFIRMAR'),
                          onPressed: () => Get.back<bool>(result: true),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colours.BlueAccented)),
                          child: Text('CANCELAR'),
                          onPressed: () => Get.back<bool>(result: false),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
