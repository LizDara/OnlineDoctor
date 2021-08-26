import 'dart:convert';

List<Specialty> specialtyFromJson(String str) =>
    List<Specialty>.from(json.decode(str).map((x) => Specialty.fromJson(x)));

String specialtyToJson(List<Specialty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Specialty {
  Specialty({
    this.id,
    this.nombre,
    this.descripcion,
  });

  int? id;
  String? nombre;
  String? descripcion;

  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
      };
}
