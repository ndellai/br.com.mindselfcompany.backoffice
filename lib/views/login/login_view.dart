import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/login_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: controller.isLoading.isTrue
                ? Load()
                : LayoutBuilder(
                    builder: (_, constraints) {
                      if (constraints.maxHeight < 250) return Container();

                      return Stack(
                        children: [
                          Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: Image.asset(
                                "assets/imagens/fundo.png",
                                fit: BoxFit.cover,
                              )),
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            alignment: Alignment.center,
                            child: Opacity(
                              opacity: 0.8,
                              child: Container(
                                width: constraints.maxWidth / 2,
                                height: constraints.maxHeight / 2,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40))),
                                  elevation: 5.0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Container(
                                        width: (constraints.maxWidth / 2) / 4,
                                        height: constraints.maxHeight,
                                        color: Colours.Purple,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                height: constraints.maxHeight *
                                                    0.27,
                                                child: Image.asset(
                                                  "assets/imagens/logo.png",
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  width: constraints.maxWidth *
                                                      0.08,
                                                )),
                                            Container(
                                                child: Image.asset(
                                              "assets/imagens/logosotexto.png",
                                              width:
                                                  constraints.maxWidth * 0.11,
                                            )),
                                            Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "MeDiT",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 40),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          width: (constraints.maxWidth / 2) -
                                              ((constraints.maxWidth / 2) / 4) -
                                              10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.08,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: TextFormField(
                                                      controller:
                                                          controller.logemail,
                                                      cursorColor: Colors.white,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      validator: (email) {
                                                        return null;
                                                      },
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              fillColor:
                                                                  Colours.Blue,
                                                              errorStyle:
                                                                  TextStyle(
                                                                color: Colours
                                                                    .BlueAccented,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                backgroundColor:
                                                                    Color(
                                                                        0x22000000),
                                                              ),
                                                              errorMaxLines: 2,
                                                              filled: true,
                                                              hintText:
                                                                  'E-MAIL',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    constraints
                                                                            .maxHeight *
                                                                        0.02,
                                                              ),
                                                              prefixIcon:
                                                                  Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .horizontal(
                                                                    left: Radius
                                                                        .circular(
                                                                            4),
                                                                  ),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 3,
                                                                        right:
                                                                            12),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: Icon(
                                                                  Icons
                                                                      .account_circle,
                                                                  color: Colours
                                                                      .Blue,
                                                                  size: constraints
                                                                          .maxHeight *
                                                                      0.042,
                                                                ),
                                                              )),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.05,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: TextFormField(
                                                      controller:
                                                          controller.logsenha,
                                                      cursorColor: Colors.white,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      validator: (email) {
                                                        return null;
                                                      },
                                                      obscureText: true,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              fillColor:
                                                                  Colours.Blue,
                                                              errorStyle:
                                                                  TextStyle(
                                                                color: Colours
                                                                    .BlueAccented,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                backgroundColor:
                                                                    Color(
                                                                        0x22000000),
                                                              ),
                                                              errorMaxLines: 2,
                                                              filled: true,
                                                              hintText: 'SENHA',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    constraints
                                                                            .maxHeight *
                                                                        0.02,
                                                              ),
                                                              prefixIcon:
                                                                  Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .horizontal(
                                                                    left: Radius
                                                                        .circular(
                                                                            4),
                                                                  ),
                                                                ),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 3,
                                                                        right:
                                                                            12),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child: Icon(
                                                                  Icons.lock,
                                                                  color: Colours
                                                                      .Blue,
                                                                  size: constraints
                                                                          .maxHeight *
                                                                      0.042,
                                                                ),
                                                              )),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight *
                                                    0.05,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        minimumSize: MaterialStateProperty
                                                            .resolveWith(
                                                                (states) => Size(
                                                                    constraints
                                                                            .maxWidth *
                                                                        0.3,
                                                                    constraints
                                                                            .maxHeight *
                                                                        0.08)),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colours
                                                                    .BlueAccented),
                                                      ),
                                                      onPressed: () async {
                                                        await controller
                                                            .sendValues();
                                                      },
                                                      child: Text(
                                                        "ENTRAR",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: constraints
                                                                    .maxHeight *
                                                                0.025),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.05,
                                                    child: Text(
                                                      "",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )));
  }
}
