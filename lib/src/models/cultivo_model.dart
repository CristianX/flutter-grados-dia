// To parse this JSON data, do
//
//     final cultivoResponse = cultivoResponseFromJson(jsonString);

import 'dart:convert';

CultivoResponse cultivoResponseFromJson(String str) => CultivoResponse.fromJson(json.decode(str));

String cultivoResponseToJson(CultivoResponse data) => json.encode(data.toJson());

class CultivoResponse {
    bool ok;
    List<Cultivo> cultivo;

    CultivoResponse({
        this.ok,
        this.cultivo,
    });

    factory CultivoResponse.fromJson(Map<String, dynamic> json) => CultivoResponse(
        ok: json["ok"],
        cultivo: List<Cultivo>.from(json["cultivo"].map((x) => Cultivo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "cultivo": List<dynamic>.from(cultivo.map((x) => x.toJson())),
    };
}

class Cultivo {
    String id;
    DateTime fecha;
    bool estado;
    Hectarea hectarea;
    int v;

    Cultivo({
        this.id,
        this.fecha,
        this.estado,
        this.hectarea,
        this.v,
    });

    factory Cultivo.fromJson(Map<String, dynamic> json) => Cultivo(
        id: json["_id"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        hectarea: json["hectarea"] == null ? null : Hectarea.fromJson(json["hectarea"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fecha": fecha.toIso8601String(),
        "estado": estado,
        "hectarea": hectarea == null ? null : hectarea.toJson(),
        "__v": v,
    };
}

class Hectarea {
    String id;
    String nombre;
    double latitud;
    double longitud;
    String hacienda;
    int v;

    Hectarea({
        this.id,
        this.nombre,
        this.latitud,
        this.longitud,
        this.hacienda,
        this.v,
    });

    factory Hectarea.fromJson(Map<String, dynamic> json) => Hectarea(
        id: json["_id"],
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        hacienda: json["hacienda"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
        "hacienda": hacienda,
        "__v": v,
    };
}
