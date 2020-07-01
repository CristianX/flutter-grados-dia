import 'package:flutter/material.dart';

// Http
import 'package:http/http.dart' as http;

// Models
import 'package:grados_dia_app/src/models/hacienda_model.dart';
export 'package:grados_dia_app/src/models/hacienda_model.dart';

final _url = "https://brocolera.herokuapp.com/hacienda";

class HaciendaService with ChangeNotifier {

  List<Hacienda> haciendas = [];

  HaciendaService() {
    
    getHaciendas();

  }


  // GET Haciendas
  getHaciendas() async {
    final resp = await http.get(_url);
    final haciendaResp = haciendaResponseFromJson(resp.body);

    this.haciendas.addAll(haciendaResp.hacienda);

    notifyListeners();
  }

  // POST

  postHacienda( Hacienda hacienda ) async {

    final resp = await http.post(_url, body:  <String, dynamic> {
      'nombre' : hacienda.nombre.toString(),
      'ubicacion': hacienda.ubicacion.toString(),
      'altitud': hacienda.altitud.toString(),
      'numeroHectareas': hacienda.numeroHectareas.toString()
    });

    // final haciendaResp = haciendaResponseFromJson(resp.body);
    // this.haciendas.add( haciendaResp.hacienda[0] );
    haciendas = [];
    getHaciendas();
    
    // notifyListeners();

  }

  // DETELE
  deleteHacienda( String id ) async {

    await http.delete('$_url/$id');
    haciendas = [];
    getHaciendas();

  }

  // PUT
  putHacienda( String id, Hacienda hacienda ) async {

    await http.put('$_url/$id', body: <String, dynamic> {
      'nombre' : hacienda.nombre.toString(),
      'ubicacion': hacienda.ubicacion.toString(),
      'altitud': hacienda.altitud.toString(),
      'numeroHectareas': hacienda.numeroHectareas.toString()
    });

    haciendas = [];
    getHaciendas();

  }

}