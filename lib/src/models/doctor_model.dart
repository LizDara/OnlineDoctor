import 'dart:convert';

List<Doctor> doctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));

String doctorToJson(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctor {
  Doctor({
    required this.persona,
    required this.doctor,
  });

  Persona persona;
  DoctorClass doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        persona: Persona.fromJson(json["persona"]),
        doctor: DoctorClass.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
        "persona": persona.toJson(),
        "doctor": doctor.toJson(),
      };
}

class DoctorClass {
  DoctorClass({
    this.personaId,
    this.direccionLaboral,
    this.fechaNacimiento,
    this.sexo,
    this.codigoSs,
    this.ciPath,
    this.tituloPath,
    this.imgPath,
    this.especialidadId,
  });

  int? personaId;
  String? direccionLaboral;
  String? fechaNacimiento;
  String? sexo;
  String? codigoSs;
  String? ciPath;
  String? tituloPath;
  String? imgPath;
  int? especialidadId;

  factory DoctorClass.fromJson(Map<String, dynamic> json) => DoctorClass(
        personaId: json["persona_id"],
        direccionLaboral: json["direccion_laboral"],
        fechaNacimiento: json["fecha_nacimiento"],
        sexo: json["sexo"],
        codigoSs: json["codigo_ss"],
        ciPath: json["ci_path"],
        tituloPath: json["titulo_path"],
        imgPath: json["img_path"],
        especialidadId: json["especialidad_id"],
      );

  Map<String, dynamic> toJson() => {
        "persona_id": personaId,
        "direccion_laboral": direccionLaboral,
        "fecha_nacimiento": fechaNacimiento,
        "sexo": sexo,
        "codigo_ss": codigoSs,
        "ci_path": ciPath,
        "titulo_path": tituloPath,
        "img_path": imgPath,
        "especialidad_id": especialidadId,
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
        "id": id,
        "nombres": nombres,
        "apellidos": apellidos,
        "telefono": telefono,
        "ci": ci,
        "correo_electronico_codigo": correoElectronicoCodigo,
        "telefono_codigo": telefonoCodigo,
        "datos_verificados": datosVerificados,
        "usuario_id": usuarioId,
      };
}
