import 'package:flutter/material.dart';

class HectareasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData( color: Theme.of(context).primaryColor ),
        elevation: 0,
        title: Text('Ingreso de plantaciones', style: TextStyle( color: Theme.of(context).primaryColor )),
      ),

      body: SingleChildScrollView(
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
                _Hacienda()
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.add_location, color: Theme.of(context).primaryColor),
        SizedBox( width: 17 ),
        Flexible(
          child: TextFormField(
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
          onPressed: (){},
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

class _Hacienda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO: Llamar lista de haciendas

    return Row(

      children: <Widget>[

        Icon( Icons.store, color: Theme.of(context).primaryColor ),
        SizedBox( width: 17 ),
        Expanded(
          child: DropdownButton(
            value: ['Seleccione una hacienda'],
            // items: ,
          ),
        )
        
      ],
      
    );
  }
}