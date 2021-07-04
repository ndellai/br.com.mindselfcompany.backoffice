import 'dart:convert';

ReportAnalyticalModel reportAnalyticalModelFromJson(String str) =>
    ReportAnalyticalModel.fromJson(json.decode(str));

String reportAnalyticalModelToJson(ReportAnalyticalModel data) =>
    json.encode(data.toJson());

class ReportAnalyticalModel {
  ReportAnalyticalModel({
    this.description,
    this.weekDay,
    this.sessionDate,
    this.startSession,
    this.endSession,
    this.identification,
    this.loginDate,
    this.company,
    this.initialDate,
    this.finalDate,
    this.programType
  });

  int idLive;
  String description;
  int weekDay;
  int countAccess;
  DateTime sessionDate;
  String startSession;
  String endSession;
  DateTime initialDate;
  DateTime finalDate;
  String identification;
  DateTime loginDate;
  String company;
  String programType;

  factory ReportAnalyticalModel.fromJson(Map<String, dynamic> json) =>
      ReportAnalyticalModel(
        description: json["description"],
        weekDay: json["weekDay"],
        sessionDate: DateTime.parse(json["sessionDate"]),
        startSession: json["startSession"],
        endSession: json["endSession"],
        identification: json["identification"],
        loginDate: DateTime.parse(json["loginDate"]),
        company: json["company"],
        programType: json["programType"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "weekDay": weekDay,
        "sessionDate": sessionDate ?? DateTime.now().toIso8601String(),
        "startSession": startSession,
        "endSession": endSession,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
        "programType": programType
      };

  static List<ReportAnalyticalModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ReportAnalyticalModel.fromJson(item)).toList();
  }
}
