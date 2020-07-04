import 'package:flutter/material.dart';
import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:grados_dia_app/src/services/hectarea_service.dart' as providerHectarea;
import 'package:grados_dia_app/src/models/cultivo_model.dart';


final _calendarController = new CalendarController();

String _opcionSeleccionada;

Cultivo cultivo = new Cultivo();


class IngresarCultivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final hectareaService = Provider.of<providerHectarea.HectareaService>(context);

    // Validación que sirve para guardar en los items del dropdown menu la opción de ninguna seleccionada, servirá para posteriormente la optimización de código de la lista de dropdowns
    if( hectareaService.hectareas.isNotEmpty ) {
      _opcionSeleccionada = hectareaService.hectareas[0].id;
    } else {
      _opcionSeleccionada = 'Ninguna opción seleccionada';
    }

    cultivo.estado = false;

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData( color: Theme.of(context).primaryColor ),
        elevation: 0,
        title: Text( 'Ingreso de cultivos', style: TextStyle( color: Theme.of(context).primaryColor ) ),

      ),

      body: SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        child: Container(
          
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          child: Column(

            children: <Widget>[

              _MostrarCalendario(),
              SizedBox( height: 20 ),
              _CrearSwitchEstado(),
              SizedBox( height: 20 ),
              _CrearComboBoxHectarea( hectareaService.hectareas )

            ],

          ),

        ),

      ),
      floatingActionButton: _CrearFloatingActionButton()
      
    );
  }
}

class _MostrarCalendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(

      calendarController: _calendarController,
      calendarStyle: CalendarStyle(

        todayColor: Colors.teal,
        selectedColor: Theme.of(context).primaryColor,
        todayStyle: TextStyle(

          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white

        )

      ),

      headerStyle: HeaderStyle(

        centerHeaderTitle: true,
        formatButtonVisible: false

      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: ( date, events ){

        cultivo.fecha = date;
        print( cultivo.fecha );

      },
      locale: 'ES',
      
    );
  }
}

class _CrearSwitchEstado extends StatefulWidget {
  @override
  __CrearSwitchEstadoState createState() => __CrearSwitchEstadoState();
}

class __CrearSwitchEstadoState extends State<_CrearSwitchEstado> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        
        Icon( Icons.check, color: Theme.of(context).primaryColor ),
        
        SizedBox( width: 17 ),

        Expanded(

          child: SwitchListTile(

            title: Text( 'Estado' ),
            value: cultivo.estado,
            activeColor: Theme.of(context).primaryColor,
            onChanged: ( valor ){
              setState(() {
                cultivo.estado = valor;
              });
            },
            
          ),

        ),
      ],
    );
  }
}

class _CrearComboBoxHectarea extends StatefulWidget {

  final List<providerHectarea.Hectarea> hectareas;

  const _CrearComboBoxHectarea( this.hectareas );


  @override
  __CrearComboBoxHectareaState createState() => __CrearComboBoxHectareaState();
}

class __CrearComboBoxHectareaState extends State<_CrearComboBoxHectarea> {
  @override
  Widget build(BuildContext context) {

    

    

    List<DropdownMenuItem<String>> getHectareas(){

      List<DropdownMenuItem<String>> listaHectarea = new List();

      if( this.widget.hectareas.isNotEmpty  ){

        this.widget.hectareas.forEach((hectarea) {
          listaHectarea.add(DropdownMenuItem(
            child: Text( hectarea.nombre ),
            value: hectarea.id,
          ));
        });
      }
      else {
        listaHectarea.add(DropdownMenuItem(
          child: Text('Ninguna hectarea en existencia'),
          value: 'Ninguna hectarea en existencia',
        ));
      }


      return listaHectarea;

  }

    return Row(

      children: <Widget>[

        Icon( Icons.store, color: Theme.of(context).primaryColor ),
        SizedBox( width: 17 ),
        DropdownButton(

          items: getHectareas(),
          value: _opcionSeleccionada,
          onChanged: ( opt ){

            setState(() {
              _opcionSeleccionada = opt;
            });


          },



        )

      ],
      
    );
  }
}

class _CrearFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final cultivoService = Provider.of<CultivoService>(context);

    return FloatingActionButton(

      backgroundColor: Theme.of(context).primaryColor,
      child: Icon( Icons.save ),
      onPressed: (){
        _submit( cultivoService, context );
      },
      
    );
  }

  void _submit( CultivoService cultivoService, BuildContext context ) {

    cultivoService.postCultivos(cultivo,  _opcionSeleccionada );

    Navigator.pop(context);

  }
}