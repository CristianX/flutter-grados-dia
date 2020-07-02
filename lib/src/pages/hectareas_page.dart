import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

// Services
import 'package:grados_dia_app/src/services/hacienda_service.dart' as providerHacienda;
import 'package:grados_dia_app/src/services/hectarea_service.dart';


// TODO: cambiar hectareaService por haciendaService para el llamado de hacienda al dropDown
// TODO: Cambiar a stless widget todo

String _opcionSelccionada;

Position _posicionActual;

final formKey = GlobalKey<FormState>();

Hectarea hectarea = Hectarea();

class HectareasPage extends StatefulWidget {
  

  @override
  _HectareasPageState createState() => _HectareasPageState();
}

class _HectareasPageState extends State<HectareasPage> {
  @override
  Widget build(BuildContext context) {

    final haciendaService = Provider.of<providerHacienda.HaciendaService>(context);

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
            key: formKey,
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

class _CreandoFloatingActionButton extends StatefulWidget {
  @override
  __CreandoFloatingActionButtonState createState() => __CreandoFloatingActionButtonState();
}

class __CreandoFloatingActionButtonState extends State<_CreandoFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    final hectareaService = Provider.of<HectareaService>(context);

    return FloatingActionButton(

      child: Icon(Icons.save),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _submit( hectareaService ),


    );
  }

  void _submit( HectareaService hectareaService ) {
    // Validando formulario
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    // Opción seleccionada es el ide de la hacienda
    hectareaService.postHectarea(hectarea, _opcionSelccionada);

    Navigator.pop(context);

    


  }

}

class _CrearNombre extends StatefulWidget {
  @override
  __CrearNombreState createState() => __CrearNombreState();
}

class __CrearNombreState extends State<_CrearNombre> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (value) => hectarea.nombre = value,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción de la platación',
        icon: Icon(Icons.description, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
      // Validación
      validator: ( value ) {
        if( value.length < 3 ) {
          return 'Ingrese la descripción de la plantación';
        } else {
          return null;
        }
      },
      
    );
  }
}

class _Ubicacion extends StatefulWidget {

  @override
  __UbicacionState createState() => __UbicacionState();
}

class __UbicacionState extends State<_Ubicacion> {
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
            
            onSaved: (value) => hectarea.latitud =  double.parse(value),
            decoration: InputDecoration(
              labelText: 'Latitud',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            validator: ( value ) {
              if( value.isEmpty ) {
                return 'Necesario';
              } else {
                return null;
              }
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: _longitudController,
            enabled: false,
            keyboardType: TextInputType.number,
            onSaved: (value) => hectarea.longitud =  double.parse(value),
            decoration: InputDecoration(
              labelText: 'Longitud',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            // Validación
            validator: ( value ) {
              if( value.isEmpty ) {
                return 'Necesario';
              } else {
                return null;
              }
            },
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

  final List<providerHacienda.Hacienda> haciendas;

  const _Hacienda( this.haciendas );

  @override
  __HaciendaState createState() => __HaciendaState();
}

class __HaciendaState extends State<_Hacienda> {
  // TODO: Código repetido con ingresar_cultivo_page
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


    return Row(

      children: <Widget>[

        Icon( Icons.store, color: Theme.of(context).primaryColor ),
        SizedBox( width: 17 ),
        DropdownButton(
          items: getHaciendas(),
          value: _opcionSelccionada,
          onChanged: (opt) {
            setState(() {
              _opcionSelccionada = opt;
            });
          },
          // items: ,
        )
        
      ],
      
    );
  }
}