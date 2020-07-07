import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/services/predecir_meses_services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:grados_dia_app/src/models/cultivo_model.dart';


class ControlCultivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Cultivo cultivoData = ModalRoute.of(context).settings.arguments;

    final predecirMesesService = Provider.of<PredecirMesesService>(context);

    var temperaturasMaximas = predecirMesesService.temperaturasPorMeses[0].tempMax;
    var temperaturasMinimas = predecirMesesService.temperaturasPorMeses[0].tempMin;



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
      body: Column(

        children: <Widget>[

          Container(

            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<DataGrafico, String>>[
                LineSeries<DataGrafico, String>(
                  dataSource: getDataTemperaturaMaxima( temperaturasMaximas ),
                  xValueMapper: ( DataGrafico data, _ ) => data.x,
                  yValueMapper: ( DataGrafico data, _ ) => data.y,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  )
                ),
                LineSeries<DataGrafico, String>(
                  color: Colors.red,
                  dataSource: getDataTemperaturaMinima( temperaturasMinimas ),
                  xValueMapper: ( DataGrafico data, _ ) => data.x,
                  yValueMapper: ( DataGrafico data, _ ) => data.y,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  )
                ),
              ],
            ),
            
          )

        ],

      )
      
    );
  }
}

class DataGrafico {

  String x;
  double y;

  DataGrafico( this.x, this.y );

}

dynamic getDataTemperaturaMaxima( List<double> temperaturasMaximas ) {

  List<DataGrafico> dataTemperaturaMaxima = [];
  int id = 0;

  temperaturasMaximas.forEach(( temperaturaMaxima ) {

    

    dataTemperaturaMaxima.add( DataGrafico( id.toString() ,  temperaturaMaxima ) );

    id ++;
    
   });

  return dataTemperaturaMaxima;

}

dynamic getDataTemperaturaMinima( List<double> temperaturasMinimas ) {

  List<DataGrafico> dataTemperaturaMinima = [];
  int id = 0;

  temperaturasMinimas.forEach(( temperaturaMinima ) {

    

    dataTemperaturaMinima.add( DataGrafico( id.toString() ,  temperaturaMinima ) );

    id ++;
    
   });

  return dataTemperaturaMinima;

}