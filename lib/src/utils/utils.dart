import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/models/menu_model.dart';


class MenuItems {

  List<Menu> menu = [

    Menu( Icons.home, 'hacienda' ),
    Menu( Icons.local_florist, 'cultivo' ),
    Menu( Icons.poll, 'control' ),
    Menu( Icons.sentiment_satisfied, 'usuario' ),
    Menu( Icons.wb_cloudy, 'clima' )



  ];

}

bool esNumero( String textoNumero ) {

  if( textoNumero.isEmpty ) return false;

  final numero = num.tryParse( textoNumero );

  return ( numero == null ) ? false : true;

}