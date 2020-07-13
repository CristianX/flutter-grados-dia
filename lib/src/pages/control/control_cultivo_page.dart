import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/services/predecir_dias_service.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_mobile_carousel/carousel.dart';



import 'package:grados_dia_app/src/models/cultivo_model.dart';
import 'package:grados_dia_app/src/services/predecir_meses_services.dart';
import 'package:grados_dia_app/src/models/data_grafico_model.dart';
import 'package:grados_dia_app/src/widgets/grafica_linear.dart';
import 'package:grados_dia_app/src/utils/utils_cultivo.dart' as utilsCultivo;





class ControlCultivoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  

    final Cultivo cultivoData = ModalRoute.of(context).settings.arguments;

    final predecir3MesesService = Provider.of<PredecirMesesService>(context);

    final predecirPor5DiasService = Provider.of<PredecirDiasService>(context);

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
      body: ( predecir3MesesService.getPrediccionesPor3Meses.length == 0 || predecirPor5DiasService.getPrediccionesPor5Dias.length == 0 ) ? Center ( 
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
       ) : SingleChildScrollView(
         physics: BouncingScrollPhysics(),
         child: Carousel(
           rowCount: 1,
           children: <Widget>[
             _GraficaPrediccion3Meses(predicciones3Meses: predecir3MesesService, fecha: cultivoData.fecha),
             _GraficaPrediccion5Dias(predicciones5Dias: predecirPor5DiasService, fecha: cultivoData.fecha),
           ],
         )
      )
    );
  }
}



class _GraficaPrediccion3Meses extends StatelessWidget {

  final PredecirMesesService predicciones3Meses;
  final DateTime fecha;

  _GraficaPrediccion3Meses({
    @required this.predicciones3Meses,
    @required this.fecha
  });


  @override
  Widget build(BuildContext context) {
    
    final List<charts.Series<DataGrafico, DateTime>> _dataGraficoPreddicciones3Meses = new List();
    // TODO: optimizar esto en utils
    initializeDateFormatting('es');
    final formatoFecha = new DateFormat.yMMMMd('es');

    int contador3Meses;

    if( predicciones3Meses.getPrediccionesPor3Meses.length != 0 ) {

      contador3Meses = utilsCultivo.calculoGradosDia( predicciones3Meses.getPrediccionesPor3Meses );

    }


    
    _dataGraficoPreddicciones3Meses.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.red ),
          id: '° Máxima',
          data: ( predicciones3Meses.getPrediccionesPor3Meses.length == 0  ) ? List() 
          : utilsCultivo.getDataTemperatura( fecha, predicciones3Meses.getPrediccionesPor3Meses[0].tempMax, contador3Meses ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );

    _dataGraficoPreddicciones3Meses.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.blue ),
          id: '° Mínima',
          data: ( predicciones3Meses.getPrediccionesPor3Meses.length == 0  ) ? List() 
          : utilsCultivo.getDataTemperatura( fecha, predicciones3Meses.getPrediccionesPor3Meses[0].tempMin, contador3Meses ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );
    
    return Container(

      height: 300,
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: <Widget>[
          Text( 'Temperatura (3 meses)', style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.bold ) ),
          Expanded(
            child: GraficaLinear(_dataGraficoPreddicciones3Meses)
          ),
          SizedBox( height: 10 ),
          Text( 'Cosecha: ' + formatoFecha.format( DateTime(fecha.year, fecha.month, fecha.day + (contador3Meses - 1))  ), 
            style: TextStyle( 
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold
          ))
        ],
      ),
      
    );
  }
}

class _GraficaPrediccion5Dias extends StatelessWidget {

  final PredecirDiasService predicciones5Dias;
  final DateTime fecha;

  _GraficaPrediccion5Dias({
    @required this.predicciones5Dias,
    @required this.fecha
  });

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<DataGrafico, DateTime>> _dataGraficoPreddicciones5Dias = new List();
    // TODO: optimizar esto en utils
    initializeDateFormatting('es');
    final formatoFecha = new DateFormat.yMMMMd('es');

    int contador5Dias;

    if( predicciones5Dias.getPrediccionesPor5Dias.length != 0 ) {

      contador5Dias = utilsCultivo.calculoGradosDia( predicciones5Dias.getPrediccionesPor5Dias );

    }


    
    _dataGraficoPreddicciones5Dias.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.red ),
          id: '° Máxima',
          data: ( predicciones5Dias.getPrediccionesPor5Dias.length == 0  ) ? List() 
          : utilsCultivo.getDataTemperatura( fecha, predicciones5Dias.getPrediccionesPor5Dias[0].tempMax, contador5Dias ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );

    _dataGraficoPreddicciones5Dias.add(
      charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor( Colors.blue ),
          id: '° Mínima',
          data: ( predicciones5Dias.getPrediccionesPor5Dias.length == 0  ) ? List() 
          : utilsCultivo.getDataTemperatura( fecha, predicciones5Dias.getPrediccionesPor5Dias[0].tempMin, contador5Dias ),
          domainFn: (DataGrafico dataGrafico, _) => dataGrafico.dias,
          measureFn: ( DataGrafico dataGrafico, _ ) => dataGrafico.data
        )
    );
    
    return Container(

      height: 300,
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: <Widget>[
          Text( 'Temperatura (5 días)', style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.bold ) ),
          Expanded(
            child: GraficaLinear(_dataGraficoPreddicciones5Dias)
          ),
          SizedBox( height: 10 ),
          Text( 'Cosecha: ' + formatoFecha.format( DateTime(fecha.year, fecha.month, fecha.day + (contador5Dias - 1))  ), 
            style: TextStyle( 
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold
          ))
        ],
      ),
      
    );
  }
}

