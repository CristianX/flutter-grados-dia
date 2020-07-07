import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/models/predecir_meses_model.dart';

// Http
import 'package:http/http.dart' as http;

final _url = 'https://brocolera.herokuapp.com/predecir';

class PredecirMesesService with ChangeNotifier {


  Map<String , List<Predecir>> prediccionesPor3Meses = {};

  String _idCultivo;

  get cultivoSeleccionado => this._idCultivo;
  set cultivoSeleccionado ( String valor ) {

    if( this.prediccionesPor3Meses[valor] == null ) {
      this.prediccionesPor3Meses[valor] = new List();
    }


    this._idCultivo = valor;
    this.getTemperaturasPorMeses( valor );

    notifyListeners();

  }

  List<Predecir> get getPrediccionesPor3Meses => this.prediccionesPor3Meses[ this._idCultivo ];


  getTemperaturasPorMeses( String id ) async {

    if( this.prediccionesPor3Meses[id].length > 0 ) {
      return this.prediccionesPor3Meses[id];
    }

    final resp = await http.get('$_url/$id');

    final prediccionPor3MesesResponse = predecirMesesResponseFromJson( resp.body );

    this.prediccionesPor3Meses[id].addAll( prediccionPor3MesesResponse.predecir );

    notifyListeners();
    

  }

  

}