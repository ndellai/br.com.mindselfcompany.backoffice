import 'dart:convert';

String companyDtoToJson(CompanyDto data) => json.encode(data.toJson());

class CompanyDto {
  CompanyDto({this.idCompany, this.name});

  int idCompany;
  String name;

  Map<String, dynamic> toJson() => {
        "idCompany": idCompany,
        "name": name,
      };
}
