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
      this.sector,
      this.phone});

  int? idEmployee;
  String? email;
  String? registration;
  CompanyModel? company;
  int? idCompany;
  String? name;
  String? area;
  String? sector;
  String? phone;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      idEmployee: json["idEmployee"],
      email: json["email"] ?? "",
      registration: json["registration"] ?? "",
      company: CompanyModel.fromJson(json["company"]),
      name: json["name"],
      area: json["area"] ?? "",
      sector: json["sector"] ?? "",
      phone: json["phone"] ?? "");

  Map<String, dynamic> toJson() => {
        "idEmployee": idEmployee,
        "email": email,
        "registration": registration,
        "idCompany": idCompany,
        "name": name,
        "area": area,
        "sector": sector,
        "phone": phone
      };

  static List<EmployeeModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => EmployeeModel.fromJson(item)).toList();
  }
}
