import 'dart:convert';

String authenticationDtoToJson(CompanyApplicationAuthenticationDto data) =>
    json.encode(data.toJson());

class CompanyApplicationAuthenticationDto {
  CompanyApplicationAuthenticationDto(
      {this.idCompany, this.idApplication, this.idAuthentication});

  int? idCompany;
  int? idApplication;
  int? idAuthentication;

  Map<String, dynamic> toJson() => {
        "idCompany": idCompany,
        "idApplication": idApplication,
        "idAuthentication": idAuthentication
      };
}
