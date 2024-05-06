import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAdd extends StatefulWidget {
  @override
  _UserAddState createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colours.Purple,
        height: 30,
        child: Text(
            "Copyright © ${DateTime.now().year} - MINDSELF DESENVOLVIMENTO HUMANO LTDA",
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.01)),
      ),
      appBar: AppBar(
        backgroundColor: Colours.Purple,
        title: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  "Usuários",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "(Inclusão)",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          alignment: Alignment.center,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          width: constraints.maxWidth,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            validator: (email) {
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colours.Purple)),
                              focusColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: Colors.black),
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
                              labelText: 'NOME:',
                              hintText: "Informe o nome do usuário...",
                              hintStyle: TextStyle(
                                fontSize: constraints.maxHeight * 0.03,
                              ),
                              labelStyle: TextStyle(
                                  fontSize: constraints.maxHeight * 0.03,
                                  color: Colours.Blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: constraints.maxWidth,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            validator: (email) {
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colours.Purple)),
                              focusColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: Colors.black),
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
                              labelText: 'E-MAIL:',
                              hintText: "Informe o e-mail do usuário...",
                              hintStyle: TextStyle(
                                fontSize: constraints.maxHeight * 0.03,
                              ),
                              labelStyle: TextStyle(
                                  fontSize: constraints.maxHeight * 0.03,
                                  color: Colours.Blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
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
                                    minimumSize:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Size(
                                                constraints.maxWidth * 0.2,
                                                constraints.maxHeight * 0.08)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colours.BlueAccented),
                                  ),
                                  onPressed: () {
                                    //_sendValues();
                                  },
                                  child: Text(
                                    "SALVAR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxHeight * 0.03),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Size(
                                                constraints.maxWidth * 0.2,
                                                constraints.maxHeight * 0.08)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colours.BlueAccented),
                                  ),
                                  onPressed: () async {
                                    Get.back();
                                  },
                                  child: Text(
                                    "VOLTAR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxHeight * 0.03),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
