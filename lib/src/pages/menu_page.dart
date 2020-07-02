import 'package:flutter/material.dart';


import 'package:grados_dia_app/src/models/menu_model.dart';
import 'package:grados_dia_app/src/pages/clima/listar_clima_page.dart';
import 'package:grados_dia_app/src/pages/control/listar_control_page.dart';
import 'package:grados_dia_app/src/pages/cultivo/listar_cultivos_page.dart';
import 'package:grados_dia_app/src/pages/hacienda/listar_haciendas_page.dart';
import 'package:grados_dia_app/src/pages/usuario/listar_usuarios_page.dart';
import 'package:grados_dia_app/src/services/navegacion_floating_service.dart';
import 'package:grados_dia_app/src/utils/utils.dart' as utils ;
import 'package:provider/provider.dart';

// TODO: Crear un provider para Navigation.pop del floatingActionButton


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  String seleccion = 'hacienda';

  @override
  Widget build(BuildContext context) {

    

    final menu = utils.MenuItems().menu;


    return SafeArea(

      child: Scaffold(

        body: Column(
          children: <Widget>[
            _listaMenu( menu ),
            SizedBox( height: 10 ),
            Expanded(child: _cargarPagina(seleccion))
          ],
        ),


      ),


      
    );
  }

  Widget _listaMenu( List<Menu> menu ) {
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

                _menuBoton( menu[index] ),
                SizedBox( height: 5 ),
                // Capitalizando nombre del menú
                Text( '${ nombreMenu[0].toUpperCase() }${ nombreMenu.substring(1) }', style: TextStyle( color: ( seleccion == menu[index].nombre ) ? Theme.of(context).primaryColor : Colors.black54 ) )

              ],
            ),
          );
       },
      ),
      
    );
  }

  Widget _menuBoton(Menu menu) {
    return GestureDetector(

      onTap: (){

        setState(() {
          seleccion = menu.nombre;
        });

         
      },

      child: Container(

        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric( horizontal: 10 ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200]
        ),

        child: Icon(
          menu.icono,
          color: ( seleccion == menu.nombre ) ? Theme.of(context).primaryColor : Colors.black54,
        ),
        
      ),
      
    );
  }

  Widget _cargarPagina( String seleccion ) {

    final navegacionFloatingService = Provider.of<NavegacionFloatingService>(context);

    switch ( seleccion ) {

      case 'hacienda' : {
        navegacionFloatingService.menuSeleccionado = seleccion;
      } 
      return ListarHaciendasPage();
      case 'cultivo'  : {
        navegacionFloatingService.menuSeleccionado = seleccion;
      }
      return ListarCultivosPage();
      case 'control'  : return ListarControlPage();
      case 'usuario'  : return ListarUsuariosPage();
      case 'clima'    : return ListarClimaPage();

      default: return ListarHaciendasPage();


    }

  }

}



