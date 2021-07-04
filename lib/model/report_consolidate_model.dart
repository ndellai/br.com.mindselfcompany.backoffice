import 'dart:convert';

ReportConsolidateModel reportConsolidateModelFromJson(String str) =>
    ReportConsolidateModel.fromJson(json.decode(str));

String reportConsolidateModelToJson(ReportConsolidateModel data) =>
    json.encode(data.toJson());

class ReportConsolidateModel {
  ReportConsolidateModel({
    this.idLive,
    this.description,
    this.weekDay,
    this.countAccess,
    this.sessionDate,
    this.startSession,
    this.endSession,
    this.initialDate,
    this.finalDate,
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

  factory ReportConsolidateModel.fromJson(Map<String, dynamic> json) =>
      ReportConsolidateModel(
          idLive: json["idLive"],
          description: json["description"],
          weekDay: json["weekDay"],
          countAccess: json["countAccess"],
          sessionDate: DateTime.parse(json["sessionDate"]),
          startSession: json["startSession"],
          endSession: json["endSession"]);

  Map<String, dynamic> toJson() => {
        "idLive": idLive ?? 0,
        "description": description,
        "weekDay": weekDay,
        "countAccess": countAccess ?? 0,
        "sessionDate": sessionDate ?? DateTime.now().toIso8601String(),
        "startSession": startSession,
        "endSession": endSession,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
      };

  static List<ReportConsolidateModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ReportConsolidateModel.fromJson(item)).toList();
  }
}
