import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalUpload extends StatefulWidget {
  const ModalUpload({Key? key}) : super(key: key);

  @override
  _ModalUploadState createState() => _ModalUploadState();
}

class _ModalUploadState extends State<ModalUpload> {
  bool? _value = false;

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
                  child: Container(
                    child: Text(
                      "Importação de Colaboradores",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
              titlePadding: EdgeInsets.all(0),
              content: Container(
                width: 550,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "O conteúdo do arquivo deve ser separado por ; conforme o layout abaixo:",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Text(
                        '''nome;email-1@empresa.com.br;12345678;campo1;campo2;telefone
nome;email-2@empresa.com.br;;;;
nome;;123456789;;;
''',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "As linhas fora deste padrão serão ignoradas.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colours.Blue),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            "Contêm cabeçalho?",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          Checkbox(
                              activeColor: Colours.Green,
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colours.BlueAccented)),
                          child: Text('CONFIRMAR'),
                          onPressed: () =>
                              Get.back<String>(result: _value.toString()),
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
                          onPressed: () => Get.back<String>(result: ""),
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
