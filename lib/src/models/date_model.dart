import 'dart:convert';

List<Date> dateFromJson(String str) =>
    List<Date>.from(json.decode(str).map((x) => Date.fromJson(x)));

String dateToJson(List<Date> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Cita meetingFromJson(String str) => Cita.fromJson(json.decode(str));

class Date {
  Date({
    required this.cita,
    required this.persona,
    required this.doctor,
    required this.especialidad,
    required this.horario,
  });

  Cita cita;
  Persona persona;
  Doctor doctor;
  Especialidad especialidad;
  Horario horario;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        cita: Cita.fromJson(json["cita"]),
        persona: Persona.fromJson(json["persona"]),
        doctor: Doctor.fromJson(json["doctor"]),
        especialidad: Especialidad.fromJson(json["especialidad"]),
        horario: Horario.fromJson(json["horario"]),
      );

  Map<String, dynamic> toJson() => {
        "cita": cita.toJson(),
        "persona": persona.toJson(),
        "doctor": doctor.toJson(),
        "especialidad": especialidad.toJson(),
        "horario": horario.toJson(),
      };
}

class Cita {
  Cita({
    this.id,
    this.fechaHora,
    this.duracion,
    this.estado,
    this.enlace,
    this.reservaId,
  });

  int? id;
  String? fechaHora;
  String? duracion;
  String? estado;
  String? enlace;
  int? reservaId;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        id: json["id"],
        fechaHora: json["fecha_hora"],
        duracion: json["duracion"],
        estado: json["estado"],
        enlace: json["enlace"],
        reservaId: json["reserva_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_hora": fechaHora,
        "duracion": duracion,
        "estado": estado,
        "enlace": enlace,
        "reserva_id": reservaId,
      };
}

class Doctor {
  Doctor({
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

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
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

class Especialidad {
  Especialidad({
    this.id,
    this.nombre,
    this.descripcion,
  });

  int? id;
  String? nombre;
  String? descripcion;

  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
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

class Horario {
  Horario({
    this.id,
    this.dia,
    this.horaInicio,
    this.horaFin,
  });

  int? id;
  String? dia;
  String? horaInicio;
  String? horaFin;

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
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
