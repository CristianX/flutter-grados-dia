import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

// Services
import 'package:grados_dia_app/src/services/hacienda_service.dart';


// TODO: cambiar hectareaService por haciendaService para el llamado de hacienda al dropDown

String _opcionSelccionada;

Position _posicionActual;

class HectareasPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final haciendaService = Provider.of<HaciendaService>(context);

    // Validación si no existe hacienda
    if( haciendaService.haciendas.isNotEmpty ) {
      _opcionSelccionada = haciendaService.haciendas[0].id;
    } else {
      _opcionSelccionada = 'Ninguna hacienda en existencia';
    }

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData( color: Theme.of(context).primaryColor ),
        elevation: 0,
        title: Text('Ingreso de plantaciones', style: TextStyle( color: Theme.of(context).primaryColor )),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          margin: EdgeInsets.only( top: 50 ),
          child: Form(
            child: Column(
              children: <Widget>[
                _CrearNombre(),
                SizedBox( height: 50 ),
                _Ubicacion(),
                SizedBox( height: 50 ),
                _Hacienda( haciendaService.haciendas )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _CreandoFloatingActionButton()
    );
  }
}

class _CreandoFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      child: Icon(Icons.save),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){},


    );
  }
}

class _CrearNombre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (value) => hectarea.nombre = value,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción de la platación',
        icon: Icon(Icons.description, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
      
    );
  }
}

class _Ubicacion extends StatelessWidget {

  // Para rellenar los campos de texto de latitud y longitud
  TextEditingController _latitudController = new TextEditingController();
  TextEditingController _longitudController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.add_location, color: Theme.of(context).primaryColor),
        SizedBox( width: 17 ),
        Flexible(
          child: TextFormField(
            controller: _latitudController,
            enabled: false,
            keyboardType: TextInputType.number,
            
            // TODO: implementar onSaved
            decoration: InputDecoration(
              labelText: 'Latitud',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: _longitudController,
            enabled: false,
            keyboardType: TextInputType.number,
            // TODO: implementar onSaved
            decoration: InputDecoration(
              labelText: 'Longitud',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.my_location),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            _posicionActual = await Geolocator().getCurrentPosition( desiredAccuracy: LocationAccuracy.high );
            _latitudController.text = _posicionActual.latitude.toString();
            _longitudController.text = _posicionActual.longitude.toString();
          },
        ),
        IconButton(
          icon: Icon(Icons.not_listed_location),
          color: Theme.of(context).primaryColor,
          onPressed: (){},
        )
      ],
    );
  }
}

class _Hacienda extends StatefulWidget {

  final List<Hacienda> haciendas;

  const _Hacienda( this.haciendas );

  @override
  __HaciendaState createState() => __HaciendaState();
}

class __HaciendaState extends State<_Hacienda> {
  List<DropdownMenuItem<String>> getHaciendas(){

    List<DropdownMenuItem<String>> listaHaciendas = new List();

    // Validación si no existe hacienda
    if( this.widget.haciendas.isNotEmpty ){

      this.widget.haciendas.forEach((hacienda) {
        listaHaciendas.add(DropdownMenuItem(
          child: Text( hacienda.nombre ),
          value: hacienda.id,
        ));
      });
    }
    else {
      listaHaciendas.add(DropdownMenuItem(
        child: Text('Ninguna hacienda en existencia'),
        value: 'Ninguna hacienda en existencia',
      ));
    }


    return listaHaciendas;

  } 

  @override
  Widget build(BuildContext context) {

    

    // TODO: Llamar lista de haciendas

    return Row(

      children: <Widget>[

        Icon( Icons.store, color: Theme.of(context).primaryColor ),
        SizedBox( width: 17 ),
        Expanded(
          child: DropdownButton(
            items: getHaciendas(),
            value: _opcionSelccionada,
            onChanged: (opt) {
              setState(() {
                _opcionSelccionada = opt;
              });
            },
            // items: ,
          ),
        )
        
      ],
      
    );
  }
}