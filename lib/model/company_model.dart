import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    this.idCompany,
    this.name,
  });

  final int idCompany;
  final String name;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        idCompany: json["idCompany"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idCompany": idCompany,
        "name": name,
      };

  static List<CompanyModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => CompanyModel.fromJson(item)).toList();
  }
}
