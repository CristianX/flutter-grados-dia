import 'package:flutter/material.dart';


// Service
import 'package:grados_dia_app/src/services/hectarea_service.dart';

// Widgets
import 'package:grados_dia_app/src/widgets/maps_hectareas.dart';


// Provider
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final hectareaService = Provider.of<HectareaService>(context);


    return Scaffold(

      body: MapaHectarea( hectareaService.hectareas ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon( Icons.people ), title: Text('Inicio')),
          BottomNavigationBarItem(icon: Icon( Icons.people ), title: Text('Inicio')),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){},
      ),

    );

      // body: _Mapa()
  }
}

