import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/services/predecir_meses_services.dart';
import 'package:provider/provider.dart';

import 'package:grados_dia_app/src/models/cultivo_model.dart';


class ControlCultivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Cultivo cultivoData = ModalRoute.of(context).settings.arguments;

    final predecirMesesService = Provider.of<PredecirMesesService>(context);

    // var temperaturasMaximas = predecirMesesService.temperaturasPorMeses[0].tempMax;
    // var temperaturasMinimas = predecirMesesService.temperaturasPorMeses[0].tempMin;



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
      body: ( predecirMesesService.getPrediccionesPor3Meses.length == 0 ) ? Center( 
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
       ) : Center(
         child: Text( '${ predecirMesesService.getPrediccionesPor3Meses[0].cultivo }' ),
       ),
      
    );
  }
}