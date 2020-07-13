// To parse this JSON data, do
//
//     final predecirDiasResponse = predecirDiasResponseFromJson(jsonString);

import 'dart:convert';

PredecirDiasResponse predecirDiasResponseFromJson(String str) => PredecirDiasResponse.fromJson(json.decode(str));

String predecirDiasResponseToJson(PredecirDiasResponse data) => json.encode(data.toJson());

class PredecirDiasResponse {
    PredecirDiasResponse({
        this.ok,
        this.predecir,
    });

    bool ok;
    List<PredecirDias> predecir;

    factory PredecirDiasResponse.fromJson(Map<String, dynamic> json) => PredecirDiasResponse(
        ok: json["ok"],
        predecir: List<PredecirDias>.from(json["predecir"].map((x) => PredecirDias.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "predecir": List<dynamic>.from(predecir.map((x) => x.toJson())),
    };
}

class PredecirDias {
    PredecirDias({
        this.tempMax,
        this.tempMin,
        this.id,
        this.actualizado,
        this.fechaAct,
        this.cultivo,
        this.v,
    });

    List<double> tempMax;
    List<double> tempMin;
    String id;
    int actualizado;
    DateTime fechaAct;
    String cultivo;
    int v;

    factory PredecirDias.fromJson(Map<String, dynamic> json) => PredecirDias(
        tempMax: List<double>.from(json["tempMax"].map((x) => x.toDouble())),
        tempMin: List<double>.from(json["tempMin"].map((x) => x.toDouble())),
        id: json["_id"],
        actualizado: json["actualizado"],
        fechaAct: DateTime.parse(json["fecha_act"]),
        cultivo: json["cultivo"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "tempMax": List<dynamic>.from(tempMax.map((x) => x)),
        "tempMin": List<dynamic>.from(tempMin.map((x) => x)),
        "_id": id,
        "actualizado": actualizado,
        "fecha_act": fechaAct.toIso8601String(),
        "cultivo": cultivo,
        "__v": v,
    };
}
