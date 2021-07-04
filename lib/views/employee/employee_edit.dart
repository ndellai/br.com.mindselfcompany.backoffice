import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/employee_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';

import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeEdit extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _registrationController =
      new TextEditingController();

  final TextEditingController _areaController = new TextEditingController();

  final TextEditingController _sectorController = new TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());
  }

  Future<void> _sendValues(EmployeeController _) async {
    bool saveData = true;

    if (!_formKey.currentState.validate()) saveData = false;

    if (_.idCompany == 1000) {
      saveData = false;
      _.isValidCompany = false;
    } else
      _.isValidCompany = true;

    if (saveData) {
      var idEmployee = await FlutterSession().get("idEmployee");
      var idCompany = await FlutterSession().get("idCompany");

      _.email = _emailController.text;
      _.registration = _registrationController.text;
      _.name = _nameController.text;
      _.area = _areaController.text;
      _.sector = _sectorController.text;

      ApiResultModel result = await _.updateEmployee(idEmployee, idCompany);

      if (result.message.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador alterado!",
          snackbarStatus: (_) =>
              _ == SnackbarStatus.CLOSED ? _redirect() : null,
          duration: Duration(seconds: 1),
          colorText: Colors.white,
          backgroundColor: Colours.Green,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
        _clearData(_);
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

  void _clearData(EmployeeController _) {
    _emailController.clear();
    _registrationController.clear();
    _.idCompany = 1000;
    _nameController.clear();
    _areaController.clear();
    _sectorController.clear();
  }

  Future _redirect() async {
    await Get.delete<EmployeeController>();
    await Get.offAllNamed("/home", arguments: [1]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _redirect();
      },
      child: Scaffold(
        bottomNavigationBar: BottomPage(margin: 10),
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
                    "Colaboradores",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "(Alteração)",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
        ),
        body: GetX<EmployeeController>(
            init: EmployeeController(
                Get.find<EmployeeRepository>(), Get.find<CompanyRepository>()),
            initState: (_) async {
              if (Get.arguments != null) {
                await FlutterSession().set("idEmployee", Get.arguments[0]);
                await FlutterSession().set("idCompany", Get.arguments[1]);
              }

              var idCompany = await FlutterSession().get("idCompany");
              var idEmployee = await FlutterSession().get("idEmployee");

              await Get.put<EmployeeController>(EmployeeController(
                      Get.find<EmployeeRepository>(),
                      Get.find<CompanyRepository>()))
                  .getEmployee(idCompany, idEmployee);
            },
            dispose: (_) {
              _emailController.dispose();
              _registrationController.dispose();
              _nameController.dispose();
              _areaController.dispose();
              _sectorController.dispose();
            },
            builder: (_) {
              if (_.isLoading) return Load();

              _emailController.text = _.email;
              _registrationController.text = _.registration;
              _nameController.text = _.name;
              _areaController.text = _.area;
              _sectorController.text = _.sector;

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
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
                                    margin: EdgeInsets.only(top: 20),
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
                                        labelText: 'EMPRESA:',
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                            color: Colours.Blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child:
                                          Container(child: Text(_.companyName)),
                                    ),
                                  ),
                                  Obx(() {
                                    return _.isValidCompany
                                        ? SizedBox()
                                        : Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8.0),
                                              child: Text(
                                                "Favor selecionar a empresa.",
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
                                      height: 20,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _nameController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.name = _nameController.text;
                                      },
                                      validator: (value) {
                                        if (value.trim().isEmpty &&
                                            _nameController
                                                .text.isEmpty) {
                                          return "Favor preencher o nome";
                                        } else
                                          return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
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
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
                                        errorStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'NOME DO COLABORADOR:',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                        ),
                                        hintText:
                                            "Informe o nome do colaborador...",
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _emailController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.email = _emailController.text;
                                      },
                                      validator: (value) {
                                        if (value.trim().isEmpty &&
                                            _registrationController
                                                .text.isEmpty) {
                                          return "Favor preencher o e-mail ou a matrícula";
                                        } else if (value.trim().isNotEmpty) {
                                          if (!_isValidEmail(value))
                                            return "E-mail inválido!";
                                          else
                                            return null;
                                        } else
                                          return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
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
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
                                        errorStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'E-MAIL DO COLABORADOR:',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                        ),
                                        hintText:
                                            "Informe o e-mail do colaborador...",
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _registrationController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.registration =
                                            _registrationController.text;
                                      },
                                      validator: (value) {
                                        if (value.trim().isEmpty &&
                                            _emailController.text.isEmpty) {
                                          return "Favor preencher a matrícula ou o e-mail";
                                        } else
                                          return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
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
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
                                        errorStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'MATRÍCULA DO COLABORADOR:',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                        ),
                                        hintText:
                                            "Informe a matrícula do colaborador...",
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _areaController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.area =
                                            _areaController.text;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
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
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
                                        errorStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'ÁREA (Quebra 1):',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                        ),
                                        hintText:
                                            "Informe a área do colaborador...",
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                            color: Colours.Blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _sectorController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.sector =
                                            _sectorController.text;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
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
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Colours.BlueAccented)),
                                        errorStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                          color: Colours.BlueAccented,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        errorMaxLines: 2,
                                        filled: true,
                                        labelText: 'SETOR (Quebra 2):',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              constraints.maxHeight * 0.03,
                                        ),
                                        hintText:
                                            "Informe o setor do colaborador...",
                                        labelStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                            color: Colours.Blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight * 0.15,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 20),
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
                                                await _sendValues(_);
                                                //await makeRequest();
                                              },
                                              child: Text(
                                                "SALVAR",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.03),
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
                                                await _redirect();
                                              },
                                              child: Text(
                                                "VOLTAR",
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
                                  )
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
