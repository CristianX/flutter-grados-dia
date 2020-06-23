import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:grados_dia_app/src/services/hacienda_service.dart';

class ListarHaciendasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final haciendaService = Provider.of<HaciendaService>(context);

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: haciendaService.haciendas.length,
      itemBuilder: (BuildContext context, int index) {
        return _HaciendaCard( hacienda: haciendaService.haciendas[index], index : index );
     },
    );
  }
}

class _HaciendaCard extends StatelessWidget {

  final Hacienda hacienda;
  final int index;

  _HaciendaCard({
    @required this.hacienda,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),

      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon( Icons.home, color: Theme.of(context).primaryColor ),
            title: Text( hacienda.nombre ),
            subtitle: Text( 'Ubicación: ${ hacienda.ubicacion }\nAltitud: ${ hacienda.altitud }\nNúmero de Hectáreas: ${ hacienda.numeroHectareas }' ),
            

          )
        ],
      ),

    );
  }
}