import 'dart:convert';

import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/employee_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/modal_upload.dart';

import 'package:universal_html/html.dart' as html;
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeAdd extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = new TextEditingController();

  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _registrationController =
      new TextEditingController();

  final TextEditingController _areaController = new TextEditingController();

  final TextEditingController _sectorController = new TextEditingController();

  Future initUpload(EmployeeController _) async {
    if (_.idCompany == 1000) {
      _.isValidCompany = false;
      return false;
    } else {
      _.isValidCompany = true;

      var dialog = await Get.dialog<String>(ModalUpload());

      if (dialog.trim().isNotEmpty)
        _startWebFilePicker(
            _, dialog.toLowerCase().toLowerCase() == "true" ? true : false);
    }
  }

  Future _startWebFilePicker(EmployeeController _, bool hasHeader) async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.accept = ".csv";
    uploadInput.onChange.listen((e) {
      var files = uploadInput.files;
      var file = files[0];
      print(file.name);
      print(file.relativePath);
      var reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result, _);
        print(_.fileUpload.length);
        Future.delayed(
            Duration(milliseconds: 500), () => makeRequest(_, hasHeader));
      });
      reader.readAsDataUrl(file);
    });
    uploadInput.click();
  }

  Future makeRequest(EmployeeController _, bool hasHeader) async {
    if (await _.uploadFile(hasHeader)) {
      Get.snackbar(
        "SUCESSO",
        "Arquivo carregado com sucesso!",
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
    } else {
      Get.snackbar(
        "ERRO",
        "Não foi possível carregar o arquivo.",
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

  void _handleResult(Object result, EmployeeController _) {
    _.fileUpload = Base64Decoder().convert(result.toString().split(",").last);
  }

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
      _.email = _emailController.text;
      _.registration = _registrationController.text;
      _.name = _nameController.text;
      _.area = _areaController.text;
      _.sector = _sectorController.text;

      ApiResultModel result = await _.insertEmployee();

      if (result.message.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador cadastrado!",
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
        bottomNavigationBar: BottomPage(
          margin: 10,
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
                    "Colaboradores",
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
        body: GetX<EmployeeController>(
            init: EmployeeController(
                Get.find<EmployeeRepository>(), Get.find<CompanyRepository>()),
            initState: (_) async => await Get.put<EmployeeController>(
                    EmployeeController(Get.find<EmployeeRepository>(),
                        Get.find<CompanyRepository>()))
                .listMinifiedCompany(),
            dispose: (_) {
              _nameController.dispose();
              _emailController.dispose();
              _registrationController.dispose();
              _areaController.dispose();
              _sectorController.dispose();
            },
            builder: (_) {
              if (_.isLoading) return Load();
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
                                      child: DropdownButtonHideUnderline(
                                        child: Obx(() => DropdownButton<int>(
                                            hint:
                                                Text("Selecione a empresa ..."),
                                            style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                            ),
                                            value: _.idCompany == 1000
                                                ? null
                                                : _.idCompany,
                                            items: _.companies.map((e) {
                                              return DropdownMenuItem<int>(
                                                child: Text(e.name),
                                                value: e.idCompany,
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              _.idCompany = value;
                                              _.isValidCompany = true;
                                            })),
                                      ),
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
                                            _registrationController
                                                .text.isEmpty) {
                                          return "Favor preencher o nome do colaborador.";
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
                                        _.area = _areaController.text;
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
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      controller: _sectorController,
                                      cursorColor: Colors.black,
                                      onEditingComplete: () {
                                        _.sector = _sectorController.text;
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
                                                await initUpload(_);
                                              },
                                              child: Text(
                                                "IMPORTAR",
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
                                                await _sendValues(_);
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
