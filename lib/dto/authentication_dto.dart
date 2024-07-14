import 'dart:convert';

String authenticationDtoToJson(AuthenticationDto data) =>
    json.encode(data.toJson());

class AuthenticationDto {
  AuthenticationDto({this.idAuthentication, this.name});

  int? idAuthentication;
  String? name;

  Map<String, dynamic> toJson() => {
        "idAuthentication": idAuthentication,
        "name": name,
      };
}
