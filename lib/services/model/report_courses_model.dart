import 'dart:convert';

class ReportCoursesModel {
  ReportCoursesModel({
    this.idEmpresa,
    this.empresa,
    this.idColaborador,
    this.colaborador,
    this.email,
    this.quebra1,
    this.quebra2,
    this.matricula,
    this.idCurso,
    this.curso,
    this.idSemana,
    this.semana,
    this.idAula,
    this.aula,
    this.idMidia,
    this.nomeMidia,
    this.tipoMidia,
    this.horaInicio,
    this.horaFinal,
    this.idEmocional,
    this.emocional,
    this.idProgresso,
    this.progresso,
    this.ano,
    this.mes,
    this.dia,
    this.diaSemana,
    this.periodo,
    this.mesano,
  });

  final int? idEmpresa;
  final String? empresa;
  final int? idColaborador;
  final String? colaborador;
  final String? email;
  final dynamic quebra1;
  final String? quebra2;
  final dynamic matricula;
  final int? idCurso;
  final String? curso;
  final int? idSemana;
  final String? semana;
  final int? idAula;
  final String? aula;
  final int? idMidia;
  final String? nomeMidia;
  final String? tipoMidia;
  final DateTime? horaInicio;
  final DateTime? horaFinal;
  final int? idEmocional;
  final String? emocional;
  final String? idProgresso;
  final String? progresso;
  final int? ano;
  final int? mes;
  final int? dia;
  final String? diaSemana;
  final String? periodo;
  final String? mesano;

  factory ReportCoursesModel.fromRawJson(String str) =>
      ReportCoursesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReportCoursesModel.fromJson(Map<String, dynamic> json) =>
      ReportCoursesModel(
        idEmpresa: json["id_empresa"],
        empresa: json["empresa"],
        idColaborador: json["id_colaborador"],
        colaborador: json["colaborador"],
        email: json["email"] ?? "",
        quebra1: json["quebra1"] ?? "",
        quebra2: json["quebra2"] ?? "",
        matricula: json["matricula"] ?? "",
        idCurso: json["id_curso"],
        curso: json["curso"],
        idSemana: json["id_semana"],
        semana: json["semana"],
        idAula: json["id_aula"],
        aula: json["aula"],
        idMidia: json["id_midia"],
        nomeMidia: json["nome_midia"],
        tipoMidia: json["tipo_midia"],
        horaInicio: DateTime.parse(json["hora_inicio"]),
        horaFinal: DateTime.parse(json["hora_final"]),
        idEmocional: json["id_emocional"],
        emocional: json["emocional"],
        idProgresso: json["id_progresso"],
        progresso: json["progresso"],
        ano: json["ano"],
        mes: json["mes"],
        dia: json["dia"],
        diaSemana: json["dia_semana"],
        periodo: json["periodo"],
        mesano: json["mesano"],
      );

  Map<String, dynamic> toJson() => {
        "id_empresa": idEmpresa,
        "empresa": empresa,
        "id_colaborador": idColaborador,
        "colaborador": colaborador,
        "email": email,
        "quebra1": quebra1,
        "quebra2": quebra2,
        "matricula": matricula,
        "id_curso": idCurso,
        "curso": curso,
        "id_semana": idSemana,
        "semana": semana,
        "id_aula": idAula,
        "aula": aula,
        "id_midia": idMidia,
        "nome_midia": nomeMidia,
        "tipo_midia": tipoMidia,
        "hora_inicio": horaInicio!.toIso8601String(),
        "hora_final": horaFinal!.toIso8601String(),
        "id_emocional": idEmocional,
        "emocional": emocional,
        "id_progresso": idProgresso,
        "progresso": progresso,
        "ano": ano,
        "mes": mes,
        "dia": dia,
        "dia_semana": diaSemana,
        "periodo": periodo,
        "mesano": mesano,
      };

  static List<ReportCoursesModel>? fromJsonList(List? list) {
    if (list == null) return null;
    return list.map((item) => ReportCoursesModel.fromJson(item)).toList();
  }
}
