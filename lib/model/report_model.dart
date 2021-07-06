import 'dart:convert';

String reportModelToJson(ReportModel data) =>
    json.encode(data.toJson());

class ReportModel {
  ReportModel({
    this.initialDate,
    this.finalDate,
  });

  DateTime initialDate;
  DateTime finalDate;

  Map<String, dynamic> toJson() => {
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
      };
}
