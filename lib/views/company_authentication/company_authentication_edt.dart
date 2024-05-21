import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/form_key.dart';
import '../../controllers/company_application_authentication_controller.dart';
import 'components/application_authentication.dart';

class CompanyAuthentication
    extends GetView<CompanyApplicationAuthenticationController> {
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
                      "Autenticação Empresas",
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
          body: Obx(
            () => controller.isLoading.isTrue
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
                                                      controller
                                                          .getApplicationsAndAuthentications();
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
                                      Obx(() => controller.panel.isEmpty
                                          ? SizedBox()
                                          : Builder(builder: (context) {
                                              return Column(
                                                  children: List.generate(
                                                      controller.panel.length,
                                                      (index) {
                                                return ApplicationAuthentication(
                                                  constraints: constraints,
                                                  indexAppl: index,
                                                );
                                              }));
                                            })),
                                      controller.panel.isEmpty
                                          ? SizedBox()
                                          : Flexible(
                                              child: SizedBox(
                                                width: constraints.maxWidth,
                                                height: constraints.maxHeight *
                                                    0.15,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          minimumSize: MaterialStateProperty
                                                              .resolveWith((states) => Size(
                                                                  constraints
                                                                          .maxWidth *
                                                                      0.2,
                                                                  constraints
                                                                          .maxHeight *
                                                                      0.08)),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      Colours
                                                                          .BlueAccented),
                                                        ),
                                                        onPressed: () async {
                                                          await controller
                                                              .updateValues();
                                                        },
                                                        child: Text(
                                                          "SALVAR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: constraints
                                                                      .maxHeight *
                                                                  0.03),
                                                        ),
                                                      ),
                                                    )
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
