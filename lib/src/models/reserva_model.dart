import 'dart:convert';

Reservas reservasFromJson(String str) => Reservas.fromJson(json.decode(str));

String reservasToJson(Reservas data) => json.encode(data.toJson());

class Reservas {
  Reservas({
    this.doctorId,
    this.horarioId,
    this.fecha,
  });

  int? doctorId;
  int? horarioId;
  String? fecha;

  factory Reservas.fromJson(Map<String, dynamic> json) => Reservas(
        doctorId: json["doctor_id"],
        horarioId: json["horario_id"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "horario_id": horarioId,
        "fecha": fecha,
      };
}
