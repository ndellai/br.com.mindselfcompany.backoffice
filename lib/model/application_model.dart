import 'dart:convert';

ApplicationModel ApplicationModelFromJson(String str) =>
    ApplicationModel.fromJson(json.decode(str));

String ApplicationModelToJson(ApplicationModel data) =>
    json.encode(data.toJson());

class ApplicationModel {
  ApplicationModel({
    this.idApplication,
    this.name,
  });

  final int? idApplication;
  final String? name;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        idApplication: json["idApplication"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "idApplication": idApplication,
        "name": name,
      };

  static List<ApplicationModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => ApplicationModel.fromJson(item)).toList();
  }
}
