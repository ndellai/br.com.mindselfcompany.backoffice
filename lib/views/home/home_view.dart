import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../company/company_view.dart';
import '../employee/employee_view.dart';
import '../report/report_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (x, constraint) {
      return Obx(
        () => Stack(
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
              child: Builder(builder: (_) {
                Widget widget = Text("");

                switch (controller.selectedIndex.value) {
                  case 0:
                    widget = CompanyView();
                    break;
                  case 1:
                    widget = EmployeeView();
                    break;
                  case 2:
                    widget = Report();
                    break;
                  default:
                    Text("");
                    break;
                }

                return widget;
              }),
            ),
            Positioned(
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(
                  onTap: () => controller.extend = !controller.extend,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          extended: controller.extend,
                          backgroundColor: Colours.Purple,
                          selectedIndex: controller.selectedIndex.value,
                          elevation: 10,
                          leading: Container(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                          selectedIconTheme:
                              IconThemeData(color: Colors.white, size: 30),
                          unselectedIconTheme:
                              IconThemeData(color: Colors.white60, size: 20),
                          selectedLabelTextStyle: TextStyle(
                              color: Colors.white, fontStyle: FontStyle.italic),
                          unselectedLabelTextStyle: TextStyle(
                              color: Colors.white60,
                              fontStyle: FontStyle.normal),
                          onDestinationSelected: (int index) {
                            controller.selectedIndex = index;
                            controller.showNavigationBar =
                                !controller.showNavigationBar;
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
        ),
      );
    }));
  }
}
