import 'package:flutter/material.dart';

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


    return Scaffold(

      body: _cargarPagina( currentIndex ),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, 'hectareas'),
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




