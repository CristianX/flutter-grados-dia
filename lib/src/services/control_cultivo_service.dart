import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:grados_dia_app/src/models/control_model.dart';

final _url = 'https://brocolera.herokuapp.com/control';

class ControlCultivoService with ChangeNotifier {

  Map<String, List<ControlCultivo>> controlCultivo = {};

  String _idCultivo;

  get cultivoSeleccionado => this._idCultivo;
  set cultivoSeleccionado ( String valor ) {

    if( this.controlCultivo[valor] == null ) {
      this.controlCultivo[valor] = new List();
    }

    this._idCultivo = valor;
    this.getControlCultivo( valor );
    
    notifyListeners();

  }

  List<ControlCultivo> get getControlPorCultivo => this.controlCultivo[ this._idCultivo ];

  getControlCultivo( String id ) async {

    if( this.controlCultivo[id].length > 0 ) {
      return this.controlCultivo[id];
    }

    final resp = await http.get('$_url/$id');

    final controlCultivoResponse = controlCultivoResponseFromJson( resp.body );

    this.controlCultivo[id].addAll( controlCultivoResponse.control );

    notifyListeners();

  }


}