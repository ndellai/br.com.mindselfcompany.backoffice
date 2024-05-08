import 'package:br_com_mindselfcompany_backoffice_web/controllers/employee_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeGridView extends GetView<EmployeeController> {
  final List<EmployeeModel>? companies;
  final BoxConstraints? constraints;

  const EmployeeGridView({Key? key, this.companies, this.constraints})
      : super(key: key);

  List<Widget> getRows() {
    List<Widget> _widget = [];

    companies!.forEach((employee) {
      _widget.add(
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
          width: constraints!.maxWidth,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: constraints!.maxWidth * 0.09,
                color: Colors.grey.shade300,
                child: Text(
                  employee.idEmployee.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints!.maxHeight * 0.03),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: constraints!.maxWidth * 0.15,
                color: Colors.grey.shade300,
                child: Text(
                  employee.company!.name!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints!.maxHeight * 0.03),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  color: Colors.grey.shade300,
                  child: Text(
                    employee.email ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints!.maxHeight * 0.03),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: constraints!.maxWidth * 0.15,
                color: Colors.grey.shade300,
                child: Text(
                  employee.registration ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints!.maxHeight * 0.03),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: constraints!.maxWidth * 0.15,
                color: Colors.grey.shade300,
                child: Text(
                  employee.phone ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints!.maxHeight * 0.03),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                  color: Colors.grey.shade300,
                  width: 30,
                  height: 30,
                  child: InkWell(
                    child: Container(
                      child: Icon(Icons.edit),
                    ),
                    onTap: () async => await controller.redirectEmployeeEdt(
                        employee.idEmployee!, employee.company!.idCompany!),
                  )),
              SizedBox(
                width: 4,
              ),
              Container(
                  color: Colors.grey.shade300,
                  width: 30,
                  height: 30,
                  child: InkWell(
                    onTap: () async => await controller.deleteEmployee(
                        employee.company!.idCompany!,
                        employee.company!.name!,
                        employee.idEmployee!,
                        employee.email ?? "",
                        employee.registration ?? ""),
                    child: Container(
                      child: Icon(Icons.delete),
                    ),
                  )),
            ],
          ),
        ),
      );
    });

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getRows(),
    );
  }
}
