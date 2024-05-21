import 'dart:convert';

String applicationDtoToJson(ApplicationDto data) => json.encode(data.toJson());

class ApplicationDto {
  ApplicationDto({this.idApplication, this.name});

  int? idApplication;
  String? name;

  Map<String, dynamic> toJson() => {
        "idApplication": idApplication,
        "name": name,
      };
}
