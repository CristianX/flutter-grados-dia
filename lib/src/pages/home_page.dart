import 'package:flutter/material.dart';

import 'package:grados_dia_app/src/services/navegacion_floating_service.dart';
import 'package:provider/provider.dart';

// Vistas
import 'package:grados_dia_app/src/pages/mapa_page.dart';
import 'package:grados_dia_app/src/pages/menu_page.dart';


class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    // Llamando service
    final navegacionFloatingService = Provider.of<NavegacionFloatingService>(context);



    return Scaffold(

      body: _cargarPagina( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // TODO: implementar el FloatingButton para que pueda añadir cualquier campo de la categoria seleccionada ( Posiblemente con providers )
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, navegacionFloatingService.menuSeleccionado ),
      ),

    );

      // body: _Mapa()
  }

  Widget _cargarPagina(int paginaActual ) {

    switch( paginaActual ) {
      case 0 : return MapaPage();
      case 1 : return MenuPage();

      default: return MapaPage();
    }

  }

  _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon( Icons.spa ), title: Text('Plantaciones')),
        BottomNavigationBarItem(icon: Icon( Icons.people ), title: Text('Inicio')),
      ],
    );
  }
}




