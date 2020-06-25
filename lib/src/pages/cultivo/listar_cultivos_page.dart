import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/models/cultivo_model.dart';


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
        return _CultivoCard( cultivo: cultivos[index], index: index );
      },
    );
  }
}

class _CultivoCard extends StatelessWidget {

  final Cultivo cultivo;
  final int index;

  _CultivoCard({
    @required this.cultivo,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('es');
    final formatoFecha = new DateFormat.yMMMMd('es');


    return Card(

      elevation: 10,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon( Icons.local_florist, color: ( cultivo.estado != false ) ? Theme.of(context).primaryColor : Colors.black54 ),
        title: ( cultivo.hectarea != null ) ? Text( cultivo.hectarea.nombre ) : Text( 'No hay el texto' ),
        subtitle: Text( formatoFecha.format( cultivo.fecha ) ),
      )
      
    );
  }
}