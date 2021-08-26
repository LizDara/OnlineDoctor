import 'dart:convert';

List<Schedule> scheduleFromJson(String str) =>
    List<Schedule>.from(json.decode(str).map((x) => Schedule.fromJson(x)));

String scheduleToJson(List<Schedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schedule {
  Schedule({
    this.id,
    this.dia,
    this.horaInicio,
    this.horaFin,
  });

  int? id;
  String? dia;
  String? horaInicio;
  String? horaFin;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        dia: json["dia"],
        horaInicio: json["hora_inicio"],
        horaFin: json["hora_fin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dia": dia,
        "hora_inicio": horaInicio,
        "hora_fin": horaFin,
      };
}
