import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/models/cultivo_model.dart';
import 'package:grados_dia_app/src/services/predecir_meses_services.dart';


class ListarCultivosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final cultivoService = Provider.of<CultivoService>(context);

    return Container(
      child: ( cultivoService.cultivos.length == 0 ) ? Center(
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
      ) : _ListarCultivo(cultivos:  cultivoService.cultivos )
    );
  }
}

class _ListarCultivo extends StatelessWidget {

  final List<Cultivo> cultivos;

  _ListarCultivo({ @required this.cultivos });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: cultivos.length,
      itemBuilder: (BuildContext context, int index) {
        return _CultivoCard( cultivo: cultivos[index]);
      },
    );
  }
}

class _CultivoCard extends StatelessWidget {

  final Cultivo cultivo;

  _CultivoCard({
    @required this.cultivo,
  });

  @override
  Widget build(BuildContext context) {

    final cultivoService = Provider.of<CultivoService>(context);

    initializeDateFormatting('es');
    final formatoFecha = new DateFormat.yMMMMd('es');


    return Dismissible(

      key: UniqueKey(),
      background: Container(
        child: Icon( Icons.delete, color: Colors.white ),
        margin: EdgeInsets.symmetric( horizontal: 2, vertical: 2 ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        )
      ),
      onDismissed: ( direccion ) {

        cultivoService.deleteCultivo( cultivo.id );

      },

      child: Card(

        elevation: 10,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: Icon( Icons.local_florist, color: ( cultivo.estado != false ) ? Theme.of(context).primaryColor : Colors.black54 ),
          title: ( cultivo.hectarea != null ) ? Text( cultivo.hectarea.nombre ) : Text( 'No hay el texto' ),
          subtitle: Text( formatoFecha.format( cultivo.fecha ) ),
          onTap: () {
            final predecirMesesService = Provider.of<PredecirMesesService>(context, listen: false);
            predecirMesesService.cultivoSeleccionado = cultivo.id;
            Navigator.pushNamed(context, 'controlCultivo', arguments: cultivo);
          } 
        )
        
      ),
    );
  }
}