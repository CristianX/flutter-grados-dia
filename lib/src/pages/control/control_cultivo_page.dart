import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;



import 'package:grados_dia_app/src/models/cultivo_model.dart';
import 'package:grados_dia_app/src/services/predecir_meses_services.dart';
import 'package:grados_dia_app/src/models/data_grafico_model.dart';
import 'package:grados_dia_app/src/widgets/grafica_linear.dart';




class ControlCultivoPage extends StatelessWidget {

  final List<charts.Series<DataGrafico, DateTime>> _seriesLinearData = new List();

  @override
  Widget build(BuildContext context) {
  

    final Cultivo cultivoData = ModalRoute.of(context).settings.arguments;

    final predecirMesesService = Provider.of<PredecirMesesService>(context);

    List<double> _temperaturasMaximas = new List();
    List<double> _temperaturasMinimas = new List();

    double sumatoria=0;
    double temperaturaUmbral = 4;
    int contador=0;



    if( predecirMesesService.getPrediccionesPor3Meses.length != 0 ) {
      _temperaturasMaximas.addAll( predecirMesesService.getPrediccionesPor3Meses[0].tempMax );
      _temperaturasMinimas.addAll( predecirMesesService.getPrediccionesPor3Meses[0].tempMin );

      

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


    }


    
    _seriesLinearData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.red ),
          id: '° Máxima',
          data: ( predecirMesesService.getPrediccionesPor3Meses.length == 0  ) ? List() 
          : getDataTemperaturaMaxima( cultivoData.fecha, predecirMesesService.getPrediccionesPor3Meses[0].tempMax, contador ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );

    _seriesLinearData.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.blue ),
          id: '° Mínima',
          data: ( predecirMesesService.getPrediccionesPor3Meses.length == 0  ) ? List() 
          : getDataTemperaturaMinima( cultivoData.fecha, predecirMesesService.getPrediccionesPor3Meses[0].tempMin, contador ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );

    

    String nombreCultivo = '';

    // TODO: borrar cuando se eliminen campos innecesarios
    if( cultivoData.hectarea == null ) {
      nombreCultivo = 'No hay el texto';
    } else {
      nombreCultivo = cultivoData.hectarea.nombre;
    }

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData( color: Theme.of(context).primaryColor ),
        elevation: 0,
        title: Text( '$nombreCultivo', style: TextStyle( color: Theme.of(context).primaryColor ) ),

      ),
      body: ( predecirMesesService.getPrediccionesPor3Meses.length == 0 ) ? Center ( 
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
       ) : SingleChildScrollView(
         physics: BouncingScrollPhysics(),
         child: Container(
          height: 300,
          margin: EdgeInsets.symmetric( horizontal: 10 ),
          child: Column(
            children: <Widget>[
              Text( 'Temperatura (3 meses)', style: TextStyle( fontSize: 24.0, fontWeight: FontWeight.bold ) ),
              Expanded(
                child: GraficaLinear(_seriesLinearData)
              ),
            ],
          ),
      ),
       )
      
    );
  }
}

dynamic getDataTemperaturaMaxima( DateTime fecha, List<double> temperaturasMaximas, int contador ) {

  List<DataGrafico> dataTemperaturaMaxima = [];
  DateTime fechaGrafico = new DateTime( fecha.year, fecha.month, fecha.day );
  int id = 0;

  temperaturasMaximas.forEach(( temperaturaMaxima ) {

    if( id <= contador ){
      dataTemperaturaMaxima.add( DataGrafico( fechaGrafico, temperaturaMaxima ) );
      id ++;
      fechaGrafico = DateTime( fecha.year, fecha.month, fecha.day + id );
    }

    
  });

  return dataTemperaturaMaxima;


}

dynamic getDataTemperaturaMinima( DateTime fecha, List<double> temperaturasMinimas, int contador ) {

  List<DataGrafico> dataTemperaturaMinimas = [];
  DateTime fechaGrafico = new DateTime( fecha.year, fecha.month, fecha.day );
  int id = 0;

  temperaturasMinimas.forEach(( temperaturaMinimas ) {

    if( id <= contador ) {

      dataTemperaturaMinimas.add( DataGrafico( fechaGrafico, temperaturaMinimas ) );
      id ++;
      fechaGrafico = DateTime( fecha.year, fecha.month, fecha.day + id );

    }

    
  });

  return dataTemperaturaMinimas;


}