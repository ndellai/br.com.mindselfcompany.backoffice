import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/employee_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/employee/employee_grid_view.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/bottom_page.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/load.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/widgets/modal_confirm.dart';

class EmployeeView extends StatelessWidget {
  final TextEditingController _searchController = new TextEditingController();

  void _deleteEmployee(int idCompany, String companyName, int idEmployee,
      String email, String registration, EmployeeController _) async {
    var dialog = await Get.dialog<bool>(ModalConfirm(
        title: "Atenção!",
        text:
            "Confirma a exclusão do colaborador?\n $idEmployee ${email.isEmpty ? "" : "- " + email} ${registration.isEmpty ? "" : "- " + registration}\n Empresa: $companyName"));

    if (dialog) {
      var result = await _.deleteEmployee(idEmployee, idCompany);

      if (result.message.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador excluído!",
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

  Future<void> _redirect(int idEmployee, int idCompany) async {
    await Get.delete<EmployeeController>();
    await Get.offNamed("/employee_edt", arguments: [idEmployee, idCompany]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: GetX<EmployeeController>(
          init: EmployeeController(
              Get.find<EmployeeRepository>(), Get.find<CompanyRepository>()),
          initState: (_) => Get.put<EmployeeController>(EmployeeController(
                  Get.find<EmployeeRepository>(),
                  Get.find<CompanyRepository>()))
              .goFirstPage(),
          dispose: (_) => _searchController.clear(),
          builder: (_) {
            if (_.isLoading) return Load();
            return Scaffold(
              bottomNavigationBar: BottomPage(margin: 80),
              appBar: AppBar(
                backgroundColor: Colours.Purple,
                title: Container(
                  child: Text(
                    "Colaboradores",
                    style: TextStyle(fontSize: 30),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                      margin: EdgeInsets.only(left: 57),
                      height: constraints.maxHeight,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(
                                      top: 5, left: 20, right: 5),
                                  width: constraints.maxWidth - 70,
                                  height: 40,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 40,
                                          child: TextFormField(
                                            controller: _searchController,
                                            cursorColor: Colors.black,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: BorderSide.none,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.only(left: 20),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              fillColor: Colors.grey.shade300,
                                              errorMaxLines: 2,
                                              filled: true,
                                              hintText:
                                                  'Pesquise por empresa ou nome ou e-mail ou matrícula...',
                                              hintStyle: TextStyle(
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _.filter = _searchController.text
                                              .toUpperCase();
                                          _.actualPage = 1;
                                          _.goFirstPage();
                                        },
                                        child: FittedBox(
                                          child: Icon(
                                            Icons.search,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(
                                      top: 5, left: 20, right: 5),
                                  width: constraints.maxWidth,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: constraints.maxWidth * 0.15,
                                        color: Colours.Blue,
                                        child: Text(
                                          "ID",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  constraints.maxHeight * 0.03),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: constraints.maxWidth * 0.20,
                                        color: Colours.Blue,
                                        child: Text(
                                          "EMPRESA",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  constraints.maxHeight * 0.03),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          color: Colours.Blue,
                                          child: Text(
                                            "E-MAIL",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.03),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: constraints.maxWidth * 0.20,
                                        color: Colours.Blue,
                                        child: Text(
                                          "MATRÍCULA",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  constraints.maxHeight * 0.03),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                          color: Colours.Blue,
                                          width: 30,
                                          height: 40,
                                          child: Container()),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                          color: Colours.Blue,
                                          width: 30,
                                          height: 40,
                                          child: Text("")),
                                    ],
                                  ),
                                ),
                                EmployeeGridView(
                                  constraints: constraints,
                                  companies: _.employees,
                                  onDeleteEmployee: _deleteEmployee,
                                  onRedirect: _redirect,
                                  employeeController: _,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        color: Colours.Blue,
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Obx(() => Text(
                                                    "Página ${(_.actualPage + 1).toString()} de ${_.countPage.toString()}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: constraints
                                                                .maxHeight *
                                                            0.02),
                                                  )),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.first_page,
                                                  color: Colors.white,
                                                  size: constraints.maxHeight *
                                                      0.04,
                                                ),
                                                onPressed: () async =>
                                                    _.goFirstPage()),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.skip_previous,
                                                  color: Colors.white,
                                                  size: constraints.maxHeight *
                                                      0.04,
                                                ),
                                                onPressed: () async =>
                                                    _.goPreviousPage()),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.skip_next,
                                                  color: Colors.white,
                                                  size: constraints.maxHeight *
                                                      0.04,
                                                ),
                                                onPressed: () async =>
                                                    _.goNextPage()),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.last_page,
                                                  color: Colors.white,
                                                  size: constraints.maxHeight *
                                                      0.04,
                                                ),
                                                onPressed: () async =>
                                                    _.goLastPage()),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize: MaterialStateProperty
                                                .resolveWith((states) => Size(
                                                    constraints.maxWidth * 0.2,
                                                    constraints.maxHeight *
                                                        0.08)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Colours.BlueAccented),
                                          ),
                                          onPressed: () async {
                                            await Get.delete<
                                                EmployeeController>();
                                            await Get.offNamed("/employee_add");
                                          },
                                          child: Text(
                                            "NOVO COLABORADOR",
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
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
            );
          }),
    );
  }
}
