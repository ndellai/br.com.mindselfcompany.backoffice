import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/employee_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/form_key.dart';

class EmployeeAdd extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async => await controller.redirectHome(),
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
                      await controller.redirectHome();
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
          body: Obx(
            () => controller.isLoading.isTrue
                ? Load()
                : LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
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
                                        margin: EdgeInsets.only(top: 20),
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
                                            labelText: 'EMPRESA:',
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
                                                color: Colours.Blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          child: Obx(() =>
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton<int>(
                                                    hint: Text(
                                                        "Selecione a empresa ..."),
                                                    style: TextStyle(
                                                      fontSize: constraints
                                                              .maxHeight *
                                                          0.025,
                                                    ),
                                                    value: controller.idCompany
                                                                .value ==
                                                            1000
                                                        ? null
                                                        : controller
                                                            .idCompany.value,
                                                    items: controller.companies!
                                                        .map((e) {
                                                      return DropdownMenuItem<
                                                          int>(
                                                        child: Text(e.name!),
                                                        value: e.idCompany,
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) async {
                                                      controller.idCompany =
                                                          value!;
                                                      controller
                                                              .isValidCompany =
                                                          true;
                                                    }),
                                              )),
                                        ),
                                      ),
                                      Obx(() => controller.isValidCompany.isTrue
                                          ? SizedBox()
                                          : Container(
                                              margin: EdgeInsets.only(left: 20),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 8.0),
                                                child: Text(
                                                  "Favor selecionar a empresa.",
                                                  style: TextStyle(
                                                      fontSize: constraints
                                                              .maxHeight *
                                                          0.03,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colours.BlueAccented),
                                                ),
                                              ))),
                                      Flexible(
                                        child: SizedBox(
                                          height: 20,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          controller: controller.nameController,
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value!.trim().isEmpty &&
                                                controller.nameController.text
                                                    .isEmpty) {
                                              return "Favor preencher o nome do colaborador.";
                                            } else
                                              return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
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
                                                    constraints.maxHeight *
                                                        0.03,
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
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          controller:
                                              controller.emailController,
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value!.trim().isEmpty &&
                                                controller
                                                    .registrationController
                                                    .text
                                                    .isEmpty &&
                                                controller.phoneController.text
                                                    .isEmpty) {
                                              return "Favor preencher e-mail ou matrícula ou celular.";
                                            } else if (value
                                                .trim()
                                                .isNotEmpty) {
                                              if (!value.isEmail)
                                                return "E-mail inválido!";
                                              else {
                                                if (controller
                                                    .phoneController.text
                                                    .trim()
                                                    .isEmpty) {
                                                  return null;
                                                } else {
                                                  return "Favor preencher e-mail ou matrícula ou celular.";
                                                }
                                              }
                                            } else
                                              return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
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
                                                    constraints.maxHeight *
                                                        0.03,
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
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          controller:
                                              controller.registrationController,
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value!.trim().isEmpty &&
                                                controller.emailController.text
                                                    .isEmpty &&
                                                controller.phoneController.text
                                                    .isEmpty) {
                                              return "Favor preencher e-mail ou matrícula ou celular.";
                                            } else
                                              return null;
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                              color: Colours.BlueAccented,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorMaxLines: 2,
                                            filled: true,
                                            labelText:
                                                'MATRÍCULA DO COLABORADOR:',
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                            ),
                                            hintText:
                                                "Informe a matrícula do colaborador...",
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
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
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                11),
                                          ],
                                          controller:
                                              controller.phoneController,
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value!.trim().isNotEmpty &&
                                                controller.emailController.text
                                                    .trim()
                                                    .isNotEmpty) {
                                              return "O e-mail já foi preenchido para autenticação. Favor excluir esta informação. ";
                                            } else {
                                              if (value.trim().isEmpty &&
                                                  controller
                                                      .emailController.text
                                                      .trim()
                                                      .isEmpty) {
                                                return "Favor preencher e-mail ou matrícula ou celular.";
                                              } else {
                                                if (value.trim().length != 11 &&
                                                    controller
                                                        .emailController.text
                                                        .trim()
                                                        .isEmpty) {
                                                  return "Telefone celular inválido.";
                                                } else
                                                  return null;
                                              }
                                            }
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
                                            errorStyle: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                              color: Colours.BlueAccented,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            errorMaxLines: 2,
                                            filled: true,
                                            labelText: 'CELULAR:',
                                            hintStyle: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                            ),
                                            hintText: "Informe o celular...",
                                            labelStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
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
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          controller: controller.areaController,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
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
                                                    constraints.maxHeight *
                                                        0.03,
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
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: constraints.maxWidth,
                                        child: TextFormField(
                                          controller:
                                              controller.sectorController,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colours
                                                            .BlueAccented)),
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
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Colours.BlueAccented)),
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
                                                    constraints.maxHeight *
                                                        0.03,
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
                                                        MaterialStateProperty
                                                            .all<Color>(Colours
                                                                .BlueAccented),
                                                  ),
                                                  onPressed: () async {
                                                    await controller
                                                        .initUpload();
                                                  },
                                                  child: Text(
                                                    "IMPORTAR",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
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
                                                        MaterialStateProperty
                                                            .all<Color>(Colours
                                                                .BlueAccented),
                                                  ),
                                                  onPressed: () async {
                                                    await controller
                                                        .insertValues();
                                                  },
                                                  child: Text(
                                                    "SALVAR",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.03),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
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
                                                        MaterialStateProperty
                                                            .all<Color>(Colours
                                                                .BlueAccented),
                                                  ),
                                                  onPressed: () async {
                                                    await controller
                                                        .redirectHome();
                                                  },
                                                  child: Text(
                                                    "VOLTAR",
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
          )),
    );
  }
}
