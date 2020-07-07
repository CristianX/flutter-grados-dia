// To parse this JSON data, do
//
//     final predecirMesesResponse = predecirMesesResponseFromJson(jsonString);

import 'dart:convert';

PredecirMesesResponse predecirMesesResponseFromJson(String str) => PredecirMesesResponse.fromJson(json.decode(str));

String predecirMesesResponseToJson(PredecirMesesResponse data) => json.encode(data.toJson());

class PredecirMesesResponse {
    PredecirMesesResponse({
        this.ok,
        this.predecir,
    });

    bool ok;
    List<Predecir> predecir;

    factory PredecirMesesResponse.fromJson(Map<String, dynamic> json) => PredecirMesesResponse(
        ok: json["ok"],
        predecir: List<Predecir>.from(json["predecir"].map((x) => Predecir.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "predecir": List<dynamic>.from(predecir.map((x) => x.toJson())),
    };
}

class Predecir {
    Predecir({
        this.tempMax,
        this.tempMin,
        this.id,
        this.cultivo,
        this.v,
    });

    List<double> tempMax;
    List<double> tempMin;
    String id;
    String cultivo;
    int v;

    factory Predecir.fromJson(Map<String, dynamic> json) => Predecir(
        tempMax: List<double>.from(json["tempMax"].map((x) => x.toDouble())),
        tempMin: List<double>.from(json["tempMin"].map((x) => x.toDouble())),
        id: json["_id"],
        cultivo: json["cultivo"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "tempMax": List<dynamic>.from(tempMax.map((x) => x)),
        "tempMin": List<dynamic>.from(tempMin.map((x) => x)),
        "_id": id,
        "cultivo": cultivo,
        "__v": v,
    };
}
