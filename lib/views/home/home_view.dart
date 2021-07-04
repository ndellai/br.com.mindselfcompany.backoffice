import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/home_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/company/company_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/employee/employee_view.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/report/report_view.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/user/user_view.dart';

class HomeView extends StatelessWidget {
  final list = [
    CompanyView(),
    EmployeeView(),
    Report(),
    User(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "home",
        init: HomeController(),
        initState: (_) {
          if (Get.arguments != null) {
            Get.put<HomeController>(HomeController()).selectedIndex =
                Get.arguments[0];
          }
        },
        builder: (_) {
          return Scaffold(body: LayoutBuilder(builder: (x, constraint) {
            return Stack(
              children: <Widget>[
                Container(
                    width: constraint.maxWidth,
                    height: constraint.maxHeight,
                    child: Image.asset(
                      "assets/imagens/fundo.png",
                      fit: BoxFit.cover,
                    )),
                Opacity(
                  opacity: 0.8,
                  child: list[_.selectedIndex],
                ),
                Positioned(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    InkWell(
                      onTap: () => _.extend = !_.extend,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: IntrinsicHeight(
                            child: NavigationRail(
                              extended: _.extend,
                              backgroundColor: Colours.Purple,
                              selectedIndex: _.selectedIndex,
                              elevation: 10,
                              leading: Container(
                                  margin: EdgeInsets.only(left: 24),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  )),
                              selectedIconTheme:
                                  IconThemeData(color: Colors.white, size: 30),
                              unselectedIconTheme: IconThemeData(
                                  color: Colors.white60, size: 20),
                              selectedLabelTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                              unselectedLabelTextStyle: TextStyle(
                                  color: Colors.white60,
                                  fontStyle: FontStyle.normal),
                              onDestinationSelected: (int index) {
                                _.selectedIndex = index;
                                _.showNavigationBar = !_.showNavigationBar;
                              },
                              labelType: NavigationRailLabelType.none,
                              destinations: [
                                NavigationRailDestination(
                                  icon: Tooltip(
                                      message: "Empresas",
                                      child: Icon(Icons.account_balance)),
                                  selectedIcon: Tooltip(
                                      message: "Empresas",
                                      child: Icon(Icons.account_balance)),
                                  label: Text('Empresas'),
                                ),
                                NavigationRailDestination(
                                  icon: Tooltip(
                                      message: "Colaboradores",
                                      child: Icon(Icons.person_sharp)),
                                  selectedIcon: Tooltip(
                                      message: "Colaboradores",
                                      child: Icon(Icons.person_sharp)),
                                  label: Text('Colaboradores'),
                                ),
                                // NavigationRailDestination(
                                //   icon: Tooltip(
                                //       message: "Usuários",
                                //       child: Icon(Icons.face)),
                                //   selectedIcon: Tooltip(
                                //       message: "Usuários",
                                //       child: Icon(Icons.face)),
                                //   label: Text('Usuários'),
                                // ),
                                NavigationRailDestination(
                                  icon: Tooltip(
                                      message: "Relatórios",
                                      child: Icon(Icons.receipt_long_outlined)),
                                  selectedIcon: Tooltip(
                                      message: "Relatórios",
                                      child: Icon(Icons.receipt_long_outlined)),
                                  label: Text('Relatórios'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }));
        });
  }
}
