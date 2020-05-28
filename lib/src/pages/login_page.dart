import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _CrearFondo(),

          _LoginForm()
        ],
      ),
    );
  }
}

class _CrearFondo extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final medida = MediaQuery.of(context).size;

    final fondoVerde = Container(

      height: medida.height * 0.5,
      width: double.infinity,
      color: Color.fromRGBO(76, 175, 80, 1.0),

      

    );

    return Stack(

      children: <Widget>[

        fondoVerde,

        Container(
          padding: EdgeInsets.only( top: 110.0 ),
          margin: EdgeInsets.only( left: 20.0 ),
          child: Column(
            children: <Widget>[
              Text('Grados Día', style: TextStyle( color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold ))
            ],
          ),

        )

      ],
      
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final medida = MediaQuery.of(context).size;

    return SingleChildScrollView(

      // Eliminando señal de arrastre
      physics: BouncingScrollPhysics(),

      child: Column(

        children: <Widget>[

          SafeArea(
            child: Container(
              height: 120.0
            ),
          ),

          Container(
            height: medida.height,
            width: double.infinity,
            margin: EdgeInsets.symmetric( vertical: 60.0 ),
            padding: EdgeInsets.symmetric( vertical: 30.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only( topStart: Radius.circular(130.0) )
            ),

            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle( fontSize: 20.0, color: Color.fromRGBO(76, 175, 80, 1.0) )),
                SizedBox( height: 50 ),
                _CrearEmail(),
                SizedBox( height: 30 ),
                _CrearPassword(),
                SizedBox( height: 60 ),
                _CrearBoton(),
                SizedBox( height: 15 ),
                FlatButton(
                  child: Text('Registrarse'),
                  onPressed: (){},
                )
              ],
            ),

          ),
        ],

      ),
      
    );
  }
}

class _CrearEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon( Icons.alternate_email, color: Theme.of(context).primaryColor ),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
      ),
      
    );
  }
}

class _CrearPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          icon: Icon( Icons.lock_outline, color: Theme.of(context).primaryColor ),
          labelText: 'Conntraseña',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
      ),
    );
  }
}

class _CrearBoton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15 ),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      elevation: 20,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: (){},
      
    );
  }
}