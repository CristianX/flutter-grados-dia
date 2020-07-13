import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/models/predecir_dias_model.dart';

import 'package:http/http.dart' as http;

final _url = 'https://brocolera.herokuapp.com/predecirdia';

class PredecirDiasService with ChangeNotifier {

  Map<String , List<PredecirDias>> prediccionPor5Dias = {};

  String _idCultivo;

  get cultivoSeleccionado => this._idCultivo;
  set cultivoSeleccionado ( String valor ) {

    if( this.prediccionPor5Dias[valor] == null ) {
      this.prediccionPor5Dias[valor] = new List();
    }


    this._idCultivo = valor;
    this.getTemperaturasPor5Dias( valor );

    notifyListeners();

  }

  List<PredecirDias> get getPrediccionesPor5Dias => this.prediccionPor5Dias[ this._idCultivo ];


  getTemperaturasPor5Dias( String id ) async {

    if( this.prediccionPor5Dias[id].length > 0 ) {
      return this.prediccionPor5Dias[id];
    }

    final resp = await http.get('$_url/$id');

    final prediccionPor3MesesResponse = predecirDiasResponseFromJson( resp.body );

    this.prediccionPor5Dias[id].addAll( prediccionPor3MesesResponse.predecir );

    notifyListeners();
    

  }


}