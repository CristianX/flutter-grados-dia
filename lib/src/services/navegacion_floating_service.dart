import 'package:flutter/material.dart';

class NavegacionFloatingService with ChangeNotifier {

  String _menuSeleccionado = 'hectareas';

  // Getters y Setters
  get menuSeleccionado => this._menuSeleccionado;
  set menuSeleccionado ( String valor ) {

    this._menuSeleccionado = valor;

    notifyListeners();

  }


}