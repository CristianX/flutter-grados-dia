import 'package:flutter/material.dart';

// Vistas
import 'package:grados_dia_app/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : ( BuildContext context ) => LoginPage()
      },

      theme: ThemeData(
        primaryColor: Color.fromRGBO(76, 175, 80, 1.0)
      ),
      
    );
  }
}