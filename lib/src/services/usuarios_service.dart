import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:grados_dia_app/src/models/usuario_model.dart';
export 'package:grados_dia_app/src/models/usuario_model.dart';


final _url = 'https://brocolera.herokuapp.com/usuario';

class UsuarioService with ChangeNotifier {


  List<Usuario> usuarios = [];

  UsuarioService() {

    getUsuarios();

  }


  getUsuarios() async {

    final resp = await http.get(_url);

    final usuarioResp = usuarioResponseFromJson( resp.body );

    this.usuarios.addAll( usuarioResp.usuarios );

    notifyListeners();

  }



}