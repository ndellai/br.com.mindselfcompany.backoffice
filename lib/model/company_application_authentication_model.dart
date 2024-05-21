import 'dart:convert';

CompanyApplicationAuthenticationModel
    CompanyApplicationAuthenticationModelFromJson(String str) =>
        CompanyApplicationAuthenticationModel.fromJson(json.decode(str));

String CompanyApplicationAuthenticationModelToJson(
        CompanyApplicationAuthenticationModel data) =>
    json.encode(data.toJson());

class CompanyApplicationAuthenticationModel {
  CompanyApplicationAuthenticationModel(
      {this.idCompany, this.idApplication, this.idAuthentication});

  final int? idCompany;
  final int? idApplication;
  final int? idAuthentication;

  factory CompanyApplicationAuthenticationModel.fromJson(
          Map<String, dynamic> json) =>
      CompanyApplicationAuthenticationModel(
        idCompany: json["idCompany"],
        idApplication: json["idApplication"],
        idAuthentication: json["idAuthentication"],
      );

  Map<String, dynamic> toJson() => {
        "idCompany": idCompany,
        "idApplication": idApplication,
        "idAuthentication": idAuthentication,
      };

  static List<CompanyApplicationAuthenticationModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list
        .map((item) => CompanyApplicationAuthenticationModel.fromJson(item))
        .toList();
  }
}
