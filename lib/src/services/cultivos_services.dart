import 'package:flutter/material.dart';


// Http
import 'package:http/http.dart' as http;



// Models
import 'package:grados_dia_app/src/models/cultivo_model.dart';

final _url = 'https://brocolera.herokuapp.com/cultivo';

class CultivoService with ChangeNotifier {

  List<Cultivo> cultivos = [];

  CultivoService() {

    this.getCultivos();

  }

  getCultivos()  async {


    final resp = await http.get( _url );

    final cultivosResponse = cultivoResponseFromJson( resp.body );

    this.cultivos.addAll( cultivosResponse.cultivo );


    notifyListeners();


  }

}