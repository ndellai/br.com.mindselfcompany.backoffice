import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.idUser,
    this.name,
    this.email,
    this.password,
    this.cellPhone,
    this.dtCreateAt,
    this.active,
  });

  final String? idUser;
  final String? name;
  final String? email;
  final String? password;
  final String? cellPhone;
  final DateTime? dtCreateAt;
  final bool? active;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"] == null ? null : json["id_user"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        cellPhone: json["cell_phone"] == null ? null : json["cell_phone"],
        dtCreateAt: json["dt_create_at"] == null
            ? null
            : DateTime.parse(json["dt_create_at"]),
        active: json["active"] == null ? null : json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser == null ? null : idUser,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "cell_phone": cellPhone == null ? null : cellPhone,
        "dt_create_at":
            dtCreateAt == null ? null : dtCreateAt!.toIso8601String(),
        "active": active == null ? null : active,
      };
  static List<UserModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => UserModel.fromJson(item)).toList();
  }
}
