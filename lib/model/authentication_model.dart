import 'dart:convert';

AuthenticationModel AuthenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

String AuthenticationModelToJson(AuthenticationModel data) =>
    json.encode(data.toJson());

class AuthenticationModel {
  AuthenticationModel({
    this.idAuthentication,
    this.name,
  });

  final int? idAuthentication;
  final String? name;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        idAuthentication: json["idAuthentication"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idAuthentication": idAuthentication,
        "name": name,
      };

  static List<AuthenticationModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => AuthenticationModel.fromJson(item)).toList();
  }
}
