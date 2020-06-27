import 'dart:convert';

import 'package:flutter/material.dart';

// Http
import 'package:http/http.dart' as http;

// Modelos
import 'package:grados_dia_app/src/models/hectarea_model.dart';
export 'package:grados_dia_app/src/models/hectarea_model.dart';



final _url = 'https://brocolera.herokuapp.com/hectarea';

class HectareaService with ChangeNotifier{

  List<Hectarea> hectareas = [];

  HectareaService() {

    this.getHectareas();

  }

  // GET Hectáreas
  getHectareas() async {

    final resp = await http.get(_url);

    final hectareasResp = hectareaResponseFromJson( resp.body );

    this.hectareas.addAll( hectareasResp.hectarea );

    notifyListeners();

  }

  postHectarea( Hectarea hectarea, String idHacienda ) async {

    final resp = await http.post(_url, body: <String, String>{
      'nombre': hectarea.nombre,
      'latitud': hectarea.latitud.toString(),
      'longitud': hectarea.longitud.toString(),
      'hacienda': idHacienda
    });

    // final decodeData = json.decode( resp.body );

    // print(decodeData);

    // notifyListeners();
    // TODO: corregir la duplicidad de hectareas

    getHectareas();

    return true;

  }


}