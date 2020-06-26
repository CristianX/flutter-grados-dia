// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromJson(jsonString);

import 'dart:convert';

UsuarioResponse usuarioResponseFromJson(String str) => UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) => json.encode(data.toJson());

class UsuarioResponse {
    UsuarioResponse({
        this.ok,
        this.usuarios,
    });

    bool ok;
    List<Usuario> usuarios;

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}

class Usuario {
    Usuario({
        this.role,
        this.id,
        this.nombre,
        this.cedula,
        this.correo,
    });

    String role;
    String id;
    String nombre;
    String cedula;
    String correo;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        role: json["role"],
        id: json["_id"],
        nombre: json["nombre"],
        cedula: json["cedula"],
        correo: json["correo"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "_id": id,
        "nombre": nombre,
        "cedula": cedula,
        "correo": correo,
    };
}
