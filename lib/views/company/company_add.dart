import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/company_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';

class CompanyAdd extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _razaoSocialController =
      new TextEditingController();
  final TextEditingController _domainController = new TextEditingController();

  final TextEditingController _urlLogoController = new TextEditingController();

  Future<void> _sendValues(CompanyController _) async {
    bool saveData = true;

    if (!_formKey.currentState.validate()) saveData = false;

    if (saveData) {
      _.companyName = _razaoSocialController.text;

      ApiResultModel result = await _.insertCompany();

      if (result.message.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Empresa cadastrada!",
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

  void _clearData(CompanyController _) {
    _razaoSocialController.clear();
  }

  Future _redirect() async {
    await Get.delete<CompanyController>();
    await Get.offAllNamed("/home", arguments: [0]);
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
                    "Empresas",
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
        body: GetX<CompanyController>(
            init: CompanyController(Get.find<CompanyRepository>()),
            dispose: (_) {
              _razaoSocialController.dispose();
              _urlLogoController.dispose();
              _domainController.dispose();
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
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    width: constraints.maxWidth,
                                    child: TextFormField(
                                      cursorColor: Colors.black,
                                      validator: (razao) {
                                        if (razao.trim().isEmpty)
                                          return "Favor informar a razão social.";
                                        else
                                          return null;
                                      },
                                      controller: _razaoSocialController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              minimumSize: MaterialStateProperty
                                                  .resolveWith((states) => Size(
                                                      constraints.maxWidth *
                                                          0.2,
                                                      constraints.maxHeight *
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
                                                  .resolveWith((states) => Size(
                                                      constraints.maxWidth *
                                                          0.2,
                                                      constraints.maxHeight *
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
              );
            }),
      ),
    );
  }
}
