import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:grados_dia_app/src/services/hacienda_service.dart';

class ListarHaciendasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final haciendaService = Provider.of<HaciendaService>(context);

    return Container(
      child: ( haciendaService.haciendas.length == 0 ) ? Center(
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
      ) : _ListarHaciendas(haciendas:  haciendaService.haciendas ),
    );
  }
}

class _ListarHaciendas extends StatelessWidget {

  final List<Hacienda> haciendas;

  _ListarHaciendas({ @required this.haciendas });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: haciendas.length,
      itemBuilder: (BuildContext context, int index) {
        return _HaciendaCard( hacienda: haciendas[index] );
      },
      
    );
  }
}

class _HaciendaCard extends StatelessWidget {

  final Hacienda hacienda;

  _HaciendaCard({
    @required this.hacienda,
  });

  @override
  Widget build(BuildContext context) {

    final haciendaService = Provider.of<HaciendaService>(context);

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
        haciendaService.deleteHacienda( hacienda.id );
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),

        child: ListTile(
          leading: Icon( Icons.home, color: Theme.of(context).primaryColor ),
          title: Text( hacienda.nombre ),
          subtitle: Text( 'Ubicación: ${ hacienda.ubicacion }\nAltitud: ${ hacienda.altitud }\nNúmero de Hectáreas: ${ hacienda.numeroHectareas }' ),
          onTap: () => Navigator.pushNamed(context, 'hacienda', arguments: hacienda),
          

        ),

      ),
    );
  }
}