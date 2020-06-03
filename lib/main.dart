import 'package:flutter/material.dart';

// Services
// import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/services/hectarea_service.dart';

// Provider
import 'package:provider/provider.dart';

// Vistas
import 'package:grados_dia_app/src/pages/login_page.dart';
import 'package:grados_dia_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new HectareaService())
        // ChangeNotifierProvider(create: (_) => new  CultivoService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login' : ( BuildContext context ) => LoginPage(),
          'home'  : ( BuildContext context ) => HomePage()
        },

        theme: ThemeData(
          primaryColor: Color.fromRGBO(76, 175, 80, 1.0)
        ),
        
      ),
    );
  }
}