// To parse this JSON data, do
//
//     final hectareaResponse = hectareaResponseFromJson(jsonString);

import 'dart:convert';

HectareaResponse hectareaResponseFromJson(String str) => HectareaResponse.fromJson(json.decode(str));

String hectareaResponseToJson(HectareaResponse data) => json.encode(data.toJson());

class HectareaResponse {
    HectareaResponse({
        this.ok,
        this.hectarea,
    });

    bool ok;
    List<Hectarea> hectarea;

    factory HectareaResponse.fromJson(Map<String, dynamic> json) => HectareaResponse(
        ok: json["ok"],
        hectarea: List<Hectarea>.from(json["hectarea"].map((x) => Hectarea.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "hectarea": List<dynamic>.from(hectarea.map((x) => x.toJson())),
    };
}

class Hectarea {
    Hectarea({
        this.id,
        this.nombre,
        this.latitud,
        this.longitud,
        this.hacienda,
        this.v,
    });

    String id;
    String nombre;
    double latitud;
    double longitud;
    Hacienda hacienda;
    int v;

    factory Hectarea.fromJson(Map<String, dynamic> json) => Hectarea(
        id: json["_id"],
        nombre: json["nombre"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        hacienda: Hacienda.fromJson(json["hacienda"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "latitud": latitud,
        "longitud": longitud,
        "hacienda": hacienda.id,
        "__v": v,
    };
}

class Hacienda {
    Hacienda({
        this.id,
        this.nombre,
        this.ubicacion,
        this.altitud,
        this.numeroHectareas,
        this.v,
    });

    String id;
    String nombre;
    String ubicacion;
    String altitud;
    int numeroHectareas;
    int v;

    factory Hacienda.fromJson(Map<String, dynamic> json) => Hacienda(
        id: json["_id"],
        nombre: json["nombre"],
        ubicacion: json["ubicacion"],
        altitud: json["altitud"],
        numeroHectareas: json["numeroHectareas"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "ubicacion": ubicacion,
        "altitud": altitud,
        "numeroHectareas": numeroHectareas,
        "__v": v,
    };
}
