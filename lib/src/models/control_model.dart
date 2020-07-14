// To parse this JSON data, do
//
//     final controlCultivoResponse = controlCultivoResponseFromJson(jsonString);

import 'dart:convert';

ControlCultivoResponse controlCultivoResponseFromJson(String str) => ControlCultivoResponse.fromJson(json.decode(str));

String controlCultivoResponseToJson(ControlCultivoResponse data) => json.encode(data.toJson());

class ControlCultivoResponse {
    ControlCultivoResponse({
        this.ok,
        this.control,
    });

    bool ok;
    List<ControlCultivo> control;

    factory ControlCultivoResponse.fromJson(Map<String, dynamic> json) => ControlCultivoResponse(
        ok: json["ok"],
        control: List<ControlCultivo>.from(json["control"].map((x) => ControlCultivo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "control": List<dynamic>.from(control.map((x) => x.toJson())),
    };
}

class ControlCultivo {
    ControlCultivo({
        this.id,
        this.edadPlanta,
        this.numeroHojas,
        this.altura,
        this.diametroPella,
        this.color,
        this.fecha,
        this.cultivo,
        this.v,
    });

    String id;
    int edadPlanta;
    int numeroHojas;
    int altura;
    int diametroPella;
    String color;
    DateTime fecha;
    Cultivo cultivo;
    int v;

    factory ControlCultivo.fromJson(Map<String, dynamic> json) => ControlCultivo(
        id: json["_id"],
        edadPlanta: json["edadPlanta"],
        numeroHojas: json["numeroHojas"],
        altura: json["altura"],
        diametroPella: json["diametroPella"],
        color: json["color"],
        fecha: DateTime.parse(json["fecha"]),
        cultivo: Cultivo.fromJson(json["cultivo"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "edadPlanta": edadPlanta,
        "numeroHojas": numeroHojas,
        "altura": altura,
        "diametroPella": diametroPella,
        "color": color,
        "fecha": fecha.toIso8601String(),
        "cultivo": cultivo.toJson(),
        "__v": v,
    };
}

class Cultivo {
    Cultivo({
        this.id,
        this.fecha,
        this.estado,
        this.hectarea,
        this.v,
    });

    String id;
    DateTime fecha;
    bool estado;
    String hectarea;
    int v;

    factory Cultivo.fromJson(Map<String, dynamic> json) => Cultivo(
        id: json["_id"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        hectarea: json["hectarea"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fecha": fecha.toIso8601String(),
        "estado": estado,
        "hectarea": hectarea,
        "__v": v,
    };
}
