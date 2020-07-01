import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grados_dia_app/src/services/hacienda_service.dart';
import 'package:grados_dia_app/src/utils/utils.dart' as utils ;



Hacienda hacienda = new Hacienda();
var formKey = GlobalKey<FormState>();

class HaciendaPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Hacienda haciendaData = ModalRoute.of(context).settings.arguments;
    if( haciendaData != null ) {
      hacienda = haciendaData;
    } else {
      hacienda = Hacienda();
      
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData( color: Theme.of(context).primaryColor ),
        elevation: 0,
        title: Text('Ingreso de haciendas', style: TextStyle( color: Theme.of(context).primaryColor )),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          margin: EdgeInsets.only( top: 50 ),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _CrearCampoNombre(),
                SizedBox( height: 30 ),
                _CrearCampoUbicacion(),
                SizedBox( height: 30 ),
                _CrearCampoAltitud(),
                SizedBox( height: 30 ),
                _CrearCampoNumeroHectareas()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _CrearFloatingActionButton()
    );

  }
}

class _CrearCampoNombre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: ( hacienda != null ) ? hacienda.nombre : null,
      keyboardType: TextInputType.text,
      onSaved: (value) => hacienda.nombre = value ,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Nombre',
        icon: Icon( Icons.create, color: Theme.of(context).primaryColor ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
      validator: (value) {
        if( value.length < 3 ){
          return 'Ingrese el nombre de la hacienda';
        } else {
          return null;
        }
      },
      
    );
  }
}

class _CrearCampoUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: ( hacienda != null ) ? hacienda.ubicacion : null,
      keyboardType: TextInputType.text,
      onSaved: (value) => hacienda.ubicacion = value,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: 'Ubicación',
        icon: Icon( Icons.my_location, color: Theme.of(context).primaryColor ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20 )
        )
      ),
      validator: (value){
        if( value.length < 3 ) {
          return 'Ingrese la ubicación de la hacienda';
        } else {
          return null;
        }
      },
      
    );
  }
}

class _CrearCampoAltitud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: ( hacienda != null ) ? hacienda.altitud : null,
      keyboardType: TextInputType.number,
      onSaved: (value) => hacienda.altitud = value,
      decoration: InputDecoration(
        labelText: 'Altitud',
        icon: Icon( Icons.terrain, color: Theme.of(context).primaryColor ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20 )
        )
      ),
      validator: ( value ) {
        if( utils.esNumero( value ) ) {
          return null;
        } else {
          return 'Solo se puede ingresar números';
        }
      },
      
    );
  }
}

class _CrearCampoNumeroHectareas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: ( hacienda.numeroHectareas != null) ? hacienda.numeroHectareas.toString() : '',
      keyboardType: TextInputType.number,
      onSaved: (value) => hacienda.numeroHectareas = int.parse(value),
      decoration: InputDecoration(
        labelText: 'Número de hectáreas',
        icon: Icon( Icons.picture_in_picture_alt, color: Theme.of(context).primaryColor ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( 20 )
        )
      ),
      validator: ( value ) {
        if( utils.esNumero( value ) ) {
          return null;
        } else {
          return 'Solo se pueden ingresar números';
        }
      },
      
    );
  }
}

class _CrearFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


  final haciendsService = Provider.of<HaciendaService>(context);
    
    return FloatingActionButton(

      child: Icon( Icons.save ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _submit( haciendsService, context ) ,
      
    );

  }

  
  void _submit( HaciendaService haciendaService, BuildContext context ) {

    if( !formKey.currentState.validate() ) return;

    formKey.currentState.save();

    if( hacienda.id == null ) {
      haciendaService.postHacienda(hacienda);
    } else {
      haciendaService.putHacienda( hacienda.id , hacienda);
    }


    Navigator.pop(context);


  }

}