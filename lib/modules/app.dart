import 'package:br_com_mindselfcompany_backoffice_web/bindings/company_binding.dart';
import 'package:br_com_mindselfcompany_backoffice_web/bindings/employee_binding.dart';
import 'package:br_com_mindselfcompany_backoffice_web/bindings/login_binding.dart';
import 'package:br_com_mindselfcompany_backoffice_web/bindings/report_binding.dart';
import 'package:br_com_mindselfcompany_backoffice_web/flavors/setup.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/company/company_add.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/company/company_edit.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/employee/employee_add.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/employee/employee_edit.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/login/login_view.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:br_com_mindselfcompany_backoffice_web/views/user/user_add_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Setup.title,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Roboto"),
      home: Builder(
        builder: (_) => Login(),
      ),
      initialRoute: "/",
      initialBinding: LoginBinding(),
      getPages: [
        GetPage(
          name: "/",
          page: () => Login(),
          transition: Transition.fade,
        ),
        GetPage(
          name: "/home",
          page: () => HomeView(),
          transition: Transition.leftToRight,
          bindings: [CompanyBinding(), EmployeeBinding(), ReportBinding()],
        ),
        GetPage(
          name: "/company_add",
          page: () => CompanyAdd(),
          transition: Transition.rightToLeft,
          bindings: [CompanyBinding()],
        ),
        GetPage(
          name: "/company_edt",
          page: () => CompanyEdit(),
          transition: Transition.rightToLeft,
          bindings: [CompanyBinding()],
        ),
        GetPage(
          name: "/employee_add",
          page: () => EmployeeAdd(),
          transition: Transition.rightToLeft,
          bindings: [EmployeeBinding()],
        ),
        GetPage(
          name: "/employee_edt",
          page: () => EmployeeEdit(),
          transition: Transition.rightToLeft,
          bindings: [EmployeeBinding()],
        ),
        GetPage(
          name: "/user_add",
          page: () => UserAdd(),
          transition: Transition.rightToLeft,
          bindings: [],
        ),
      ],
    );
  }
}
