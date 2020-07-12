import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/models/menu_model.dart';
import 'package:grados_dia_app/src/models/predecir_meses_model.dart';

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


int calculoGradosDia( List<Predecir> dataPrediccion ) {

  List<double> _temperaturasMaximas = new List();
  List<double> _temperaturasMinimas = new List();
  double sumatoria=0;
  double temperaturaUmbral = 4;
  int contador=0;

  _temperaturasMaximas.addAll( dataPrediccion[0].tempMax );
  _temperaturasMinimas.addAll( dataPrediccion[0].tempMin );

  for( int i = 0; i <= _temperaturasMaximas.length -1 ; i ++ ) {

    if( _temperaturasMinimas[i] < temperaturaUmbral ) {

      _temperaturasMinimas[i] = temperaturaUmbral;

    }

    if( sumatoria <= 909 ) {

      if( (_temperaturasMaximas[i] + _temperaturasMinimas[i])/2 <= temperaturaUmbral ) {

        sumatoria = sumatoria;

      } else {

        sumatoria += (((_temperaturasMaximas[i] + _temperaturasMinimas[i])/2) - temperaturaUmbral );
        contador = i;

      }

    }

  }

  return contador;


}