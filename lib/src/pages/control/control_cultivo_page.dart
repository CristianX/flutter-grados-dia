import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:grados_dia_app/src/models/cultivo_model.dart';


class ControlCultivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Cultivo cultivoData = ModalRoute.of(context).settings.arguments;

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

            height: 400,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<DataGrafico, String>>[
                LineSeries<DataGrafico, String>(
                  dataSource: getDataColumna(),
                  xValueMapper: ( DataGrafico data, _ ) => data.x,
                  yValueMapper: ( DataGrafico data, _ ) => data.y,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  )
                )
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

dynamic getDataColumna() {

  List<DataGrafico> dataColumna = <DataGrafico>[
    DataGrafico( 'Perro joto', 20 ),
    DataGrafico( 'Perro gay', 30 ),
    DataGrafico( 'Perro puto', 40 ),
    DataGrafico( 'Perro cazquibana', 10 ),
  ];

  return dataColumna;

}