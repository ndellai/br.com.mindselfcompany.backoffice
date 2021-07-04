import 'dart:convert';

class ReportEmployeesModel {
  ReportEmployeesModel({
    this.idCompany,
    this.empresa,
    this.idEmployee,
    this.colaborador,
    this.email,
    this.quebra1,
    this.quebra2,
    this.matricula,
    this.dtAtivacao,
    this.ano,
    this.mes,
    this.dia,
    this.mesano,
  });

  final int idCompany;
  final String empresa;
  final int idEmployee;
  final String colaborador;
  final String email;
  final dynamic quebra1;
  final dynamic quebra2;
  final String matricula;
  final DateTime dtAtivacao;
  final int ano;
  final int mes;
  final int dia;
  final String mesano;

  factory ReportEmployeesModel.fromRawJson(String str) =>
      ReportEmployeesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportEmployeesModel.fromJson(Map<String, dynamic> json) =>
      ReportEmployeesModel(
        idCompany: json["id_company"],
        empresa: json["empresa"],
        idEmployee: json["id_employee"],
        colaborador: json["colaborador"],
        email: json["email"] ?? "",
        quebra1: json["quebra1"] ?? "",
        quebra2: json["quebra2"] ?? "",
        matricula: json["matricula"] ?? "",
        dtAtivacao: DateTime.parse(json["dt_ativacao"]),
        ano: json["ano"],
        mes: json["mes"],
        dia: json["dia"],
        mesano: json["mesano"],
      );

  Map<String, dynamic> toJson() => {
        "id_company": idCompany,
        "empresa": empresa,
        "id_employee": idEmployee,
        "colaborador": colaborador,
        "email": email,
        "quebra1": quebra1,
        "quebra2": quebra2,
        "matricula": matricula,
        "dt_ativacao": dtAtivacao.toIso8601String(),
        "ano": ano,
        "mes": mes,
        "dia": dia,
        "mesano": mesano,
      };

  static List<ReportEmployeesModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => ReportEmployeesModel.fromJson(item)).toList();
  }
}
