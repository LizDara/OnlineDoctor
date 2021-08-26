import 'dart:convert';

Code codeFromJson(String str) => Code.fromJson(json.decode(str));

String codeToJson(Code data) => json.encode(data.toJson());

class Code {
  Code({
    this.personaId,
    this.correoElectronicoCodigo,
    this.telefonoCodigo,
  });

  int? personaId;
  int? correoElectronicoCodigo;
  int? telefonoCodigo;

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        personaId: json["persona_id"],
        correoElectronicoCodigo: json["correo_electronico_codigo"],
        telefonoCodigo: json["telefono_codigo"],
      );

  Map<String, dynamic> toJson() => {
        "persona_id": personaId,
        "correo_electronico_codigo": correoElectronicoCodigo,
        "telefono_codigo": telefonoCodigo,
      };
}
