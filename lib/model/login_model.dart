import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({this.email, this.password, this.token, this.idUser});

  final String? email;
  final String? password;
  final String? token;
  final String? idUser;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        token: json["token"],
        idUser: json["id_user"] == null ? null : json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "token": token,
        "id_user": idUser,
      };
}
