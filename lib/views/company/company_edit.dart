import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/company_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/form_key.dart';
import '../widgets/load.dart';

class CompanyEdit extends GetView<CompanyController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async => await controller.redirectHome(),
      child: Scaffold(
          bottomNavigationBar: BottomPage(margin: 10),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colours.Purple,
            title: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      "Empresas",
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
          body: Obx(() => controller.isLoading.isTrue
              ? Load()
              : LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.only(
                                          top: 20, left: 20, right: 20),
                                      width: constraints.maxWidth,
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        validator: (razao) {
                                          if (razao!.trim().isEmpty)
                                            return "Favor informar a razão social.";
                                          else
                                            return null;
                                        },
                                        controller:
                                            controller.razaoSocialController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
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
                                          labelText: 'RAZÃO SOCIAL:',
                                          hintText: "Informe a razão social...",
                                          hintStyle: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * 0.03,
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.03,
                                              color: Colours.Blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        height: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth,
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
                                                await controller.updateValues();
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
                                                await controller.redirectHome();
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
                ))),
    );
  }
}
