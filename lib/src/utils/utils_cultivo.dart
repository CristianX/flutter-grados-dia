import 'package:grados_dia_app/src/models/data_grafico_model.dart';
import 'package:grados_dia_app/src/models/predecir_meses_model.dart';

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

List<DataGrafico> getDataTemperatura( DateTime fecha, List<double> temperaturas, int contador3Meses ) {

  List<DataGrafico> dataTemperatura = [];
  DateTime fechaGrafico = new DateTime( fecha.year, fecha.month, fecha.day );
  int id = 0;

  temperaturas.forEach(( temperatura ) {

    if( id <= contador3Meses ){
      dataTemperatura.add( DataGrafico( fechaGrafico, temperatura ) );
      id ++;
      fechaGrafico = DateTime( fecha.year, fecha.month, fecha.day + id );
    }

    
  });

  return dataTemperatura;
  
}