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

}