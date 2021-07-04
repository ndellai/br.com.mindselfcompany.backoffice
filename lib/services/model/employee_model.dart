import 'dart:convert';

import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';

EmployeeModel employeeModelFromJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  EmployeeModel(
      {this.idEmployee,
      this.email,
      this.registration,
      this.company,
      this.idCompany,
      this.name,
      this.area,
      this.sector});

  int idEmployee;
  String email;
  String registration;
  CompanyModel company;
  int idCompany;
  String name;
  String area;
  String sector;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        idEmployee: json["idEmployee"],
        email: json["email"] ?? "",
        registration: json["registration"] ?? "",
        name: json["registration"] ?? "",
        area:["area"] ?? "",
        sector:["sector"] ?? "",
        company: CompanyModel.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "idEmployee": idEmployee,
        "email": email,
        "registration": registration,
        "idCompany": idCompany,
      };

  static List<EmployeeModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => EmployeeModel.fromJson(item)).toList();
  }
}
