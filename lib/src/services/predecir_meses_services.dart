import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/models/predecir_meses_model.dart';

// Http
import 'package:http/http.dart' as http;

final _url = 'https://brocolera.herokuapp.com/predecir';

class PredecirMesesService with ChangeNotifier {

  List<Predecir> temperaturasPorMeses =[];

  String _idCultivo;

  get cultivoSeleccionado => this._idCultivo;
  set cultivoSeleccionado ( String valor ) {

    this._idCultivo = valor;
    this.getTemperaturasPorMeses( valor );

    notifyListeners();

  }


  getTemperaturasPorMeses( String id ) async {

    final resp = await http.get('$_url/$id');

    final temperaturaPorMesesResponse = predecirMesesResponseFromJson( resp.body );

    this.temperaturasPorMeses.addAll( temperaturaPorMesesResponse.predecir );

    notifyListeners();
    

  }

  

}