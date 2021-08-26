import 'dart:convert';

Pacient pacientFromJson(String str) => Pacient.fromJson(json.decode(str));

String pacientToJson(Pacient data) => json.encode(data.toJson());

String userToJson(Usuario data) => json.encode(data.toJson());

class Pacient {
  Pacient({
    required this.persona,
    required this.paciente,
    required this.usuario,
  });

  Persona persona;
  Paciente paciente;
  Usuario usuario;

  factory Pacient.fromJson(Map<String, dynamic> json) => Pacient(
        persona: Persona.fromJson(json["persona"]),
        paciente: Paciente.fromJson(json["paciente"]),
        usuario: Usuario.fromJson(json["usuario"]),
      );

  Map<String, dynamic> toJson() => {
        "persona": persona.toJson(),
        "paciente": paciente.toJson(),
        "usuario": usuario.toJson(),
      };
}

class Paciente {
  Paciente({
    this.personaId,
    this.direccionDomicilio,
    this.fechaNacimiento,
    this.sexo,
    this.codigoSeguro,
    this.tipoSeguro,
    this.imgPath,
  });

  int? personaId;
  String? direccionDomicilio;
  String? fechaNacimiento;
  String? sexo;
  String? codigoSeguro;
  String? tipoSeguro;
  String? imgPath;

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        personaId: json["persona_id"],
        direccionDomicilio: json["direccion_domicilio"],
        fechaNacimiento: json["fecha_nacimiento"],
        sexo: json["sexo"],
        codigoSeguro: json["codigo_seguro"],
        tipoSeguro: json["tipo_seguro"],
        imgPath: json["img_path"],
      );

  Map<String, dynamic> toJson() => {
        "direccion_domicilio": direccionDomicilio,
        "fecha_nacimiento": fechaNacimiento,
        "sexo": sexo,
      };
}

class Persona {
  Persona({
    this.id,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.ci,
    this.correoElectronicoCodigo,
    this.telefonoCodigo,
    this.datosVerificados,
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
  int? usuarioId;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
        ci: json["ci"],
        correoElectronicoCodigo: json["correo_electronico_codigo"],
        telefonoCodigo: json["telefono_codigo"],
        datosVerificados: json["datos_verificados"],
        usuarioId: json["usuario_id"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "ci": ci,
      };
}

class Usuario {
  Usuario({
    this.id,
    this.correoElectronico,
    this.contrasena,
    this.activo,
    this.grupoId,
  });

  int? id;
  String? correoElectronico;
  String? contrasena;
  bool? activo;
  int? grupoId;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        correoElectronico: json["correo_electronico"],
        contrasena: json["contrasena"],
        activo: json["activo"],
        grupoId: json["grupo_id"],
      );

  Map<String, dynamic> toJson() => {
        "correo_electronico": correoElectronico,
        "contrasena": contrasena,
      };
}
