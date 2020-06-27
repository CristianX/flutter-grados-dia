import 'package:flutter/material.dart';

// Services
// import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/services/hectarea_service.dart';
import 'package:grados_dia_app/src/services/hacienda_service.dart';
import 'package:grados_dia_app/src/services/navegacion_floating_service.dart';
import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/services/usuarios_service.dart';

// Provider
import 'package:provider/provider.dart';

// Vistas
import 'package:grados_dia_app/src/pages/hacienda/hacienda_page.dart';
import 'package:grados_dia_app/src/pages/login_page.dart';
import 'package:grados_dia_app/src/pages/home_page.dart';
import 'package:grados_dia_app/src/pages/hectareas_page.dart';
import 'package:grados_dia_app/src/pages/mapa_page.dart';
import 'package:grados_dia_app/src/pages/menu_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new HectareaService()),
        ChangeNotifierProvider(create: (_) => new HaciendaService()),
        ChangeNotifierProvider(create: (_) => new NavegacionFloatingService()),
        ChangeNotifierProvider(create: (_) => new  CultivoService()),
        ChangeNotifierProvider(create: (_) => new  UsuarioService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login'      : ( BuildContext context ) => LoginPage(),
          'home'       : ( BuildContext context ) => HomePage(),
          'hectareas'  : ( BuildContext context ) => HectareasPage(),
          'mapa'       : ( BuildContext context ) => MapaPage(),
          'menu'       : ( BuildContext context ) => MenuPage(),

          // Rutas de menú
          'hacienda'   : ( BuildContext context ) => HaciendaPage()
        },

        theme: ThemeData(
          primaryColor: Color.fromRGBO(76, 175, 80, 1.0)
        ),
        
      ),
    );
  }
}