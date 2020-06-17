import 'package:flutter/material.dart';


import 'package:grados_dia_app/src/models/menu_model.dart';
import 'package:grados_dia_app/src/utils/utils.dart' as utils ;

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        body: Column(
          children: <Widget>[
            _ListaMenu()
          ],
        ),


      ),


      
    );
  }
}

class _ListaMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final menu = utils.MenuItems().menu;

    return Container(

      width: double.infinity,
      height: 80,

      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {

          final nombreMenu = menu[index].nombre;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[

                _MenuBoton( menu[index] ),
                SizedBox( height: 5 ),
                // Capitalizando nombre del menú
                Text( '${ nombreMenu[0].toUpperCase() }${ nombreMenu.substring(1) }' )

              ],
            ),
          );
       },
      ),
      
    );
  }
}

class _MenuBoton extends StatelessWidget {

  final Menu menu;

  const _MenuBoton( this.menu );

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: (){
         print( menu.nombre );
      },

      child: Container(

        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric( horizontal: 10 ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),

        child: Icon(
          // TODO cambiar los items del menu a un provider para redibujar el color seleccionado
          menu.icono,
          color: ( Theme.of(context).primaryColor ),
        ),
        
      ),
      
    );
  }
}