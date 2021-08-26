import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.ci,
    this.correoElectronicoCodigo,
    this.telefonoCodigo,
    this.datosVerificados,
    this.direccionDomicilio,
    this.fechaNacimiento,
    this.usuarioId,
  });

  int? id;
  String? nombres;
  String? apellidos;
  int? telefono;
  int? ci;
  int? correoElectronicoCodigo;
  int? telefonoCodigo;
  bool? datosVerificados;
  String? direccionDomicilio;
  String? fechaNacimiento;
  int? usuarioId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        ci: json["ci"],
        correoElectronicoCodigo: json["correo_electronico_codigo"],
        telefonoCodigo: json["telefono_codigo"],
        datosVerificados: json["datos_verificados"],
        direccionDomicilio: json["direccion_domicilio"],
        fechaNacimiento: json["fecha_nacimiento"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "ci": ci,
        "correo_electronico_codigo": correoElectronicoCodigo,
        "telefono_codigo": telefonoCodigo,
        "datos_verificados": datosVerificados,
        "direccion_domicilio": direccionDomicilio,
        "fecha_nacimiento": fechaNacimiento,
        "usuario_id": usuarioId,
      };
}
