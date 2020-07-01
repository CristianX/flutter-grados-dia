// To parse this JSON data, do
//
//     final haciendaResponse = haciendaResponseFromJson(jsonString);

import 'dart:convert';

HaciendaResponse haciendaResponseFromJson(String str) => HaciendaResponse.fromJson(json.decode(str));

String haciendaResponseToJson(HaciendaResponse data) => json.encode(data.toJson());

class HaciendaResponse {
    HaciendaResponse({
        this.ok,
        this.hacienda,
    });

    bool ok;
    List<Hacienda> hacienda;

    factory HaciendaResponse.fromJson(Map<String, dynamic> json) => HaciendaResponse(
        ok: json["ok"],
        hacienda: List<Hacienda>.from(json["hacienda"].map((x) => Hacienda.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "hacienda": List<dynamic>.from(hacienda.map((x) => x.toJson())),
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
