import 'dart:convert';

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  Reservation({
    this.reserva,
    this.horario,
    this.persona,
    this.especialidad,
  });

  Reserva? reserva;
  Horario? horario;
  Persona? persona;
  Especialidad? especialidad;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        reserva: Reserva.fromJson(json["reserva"]),
        horario: Horario.fromJson(json["horario"]),
        persona: Persona.fromJson(json["persona"]),
        especialidad: Especialidad.fromJson(json["especialidad"]),
      );

  Map<String, dynamic> toJson() => {
        "reserva": reserva!.toJson(),
        "horario": horario!.toJson(),
        "persona": persona!.toJson(),
        "especialidad": especialidad!.toJson(),
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

class Reserva {
  Reserva({
    this.id,
    this.fechaCreacion,
    this.fechaActualizacion,
    this.fechaCita,
    this.estado,
    this.motivo,
    this.horarioDoctorId,
    this.pacienteId,
  });

  int? id;
  String? fechaCreacion;
  String? fechaActualizacion;
  String? fechaCita;
  String? estado;
  String? motivo;
  int? horarioDoctorId;
  int? pacienteId;

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json["id"],
        fechaCreacion: json["fecha_creacion"],
        fechaActualizacion: json["fecha_actualizacion"],
        fechaCita: json["fecha_cita"],
        estado: json["estado"],
        motivo: json["motivo"],
        horarioDoctorId: json["horario_doctor_id"],
        pacienteId: json["paciente_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha_creacion": fechaCreacion,
        "fecha_actualizacion": fechaActualizacion,
        "fecha_cita": fechaCita,
        "estado": estado,
        "motivo": motivo,
        "horario_doctor_id": horarioDoctorId,
        "paciente_id": pacienteId,
      };
}
