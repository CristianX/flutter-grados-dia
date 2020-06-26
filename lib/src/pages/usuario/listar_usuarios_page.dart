import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grados_dia_app/src/services/usuarios_service.dart';

class ListarUsuariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final usuarioService = Provider.of<UsuarioService>(context);

    return Container(
      child: ( usuarioService.usuarios.length == 0 ) ? Center(
        child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>( Theme.of(context).primaryColor ) ),
      ) : _ListarUsuarios( usuarios: usuarioService.usuarios ),
    );
  }
}

class _ListarUsuarios extends StatelessWidget {

  final List<Usuario> usuarios;

  _ListarUsuarios({ @required this.usuarios });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: usuarios.length,
      itemBuilder: (BuildContext context, int index) {
      return _UsuarioCard( usuario : usuarios[index] );
     },
    );
  }
}

class _UsuarioCard extends StatelessWidget {

  final Usuario usuario;

  _UsuarioCard({ @required this.usuario });

  @override
  Widget build(BuildContext context) {

    

    return Card(

      elevation: 10,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
      child: ListTile(
        leading: ( usuario.role == 'USER_ROLE' ) ? Icon( Icons.sentiment_satisfied, color: Theme.of(context).primaryColor ) : Icon( Icons.account_circle, color: Theme.of(context).primaryColor ) ,
        title: Text( usuario.nombre ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Cédula: ${ usuario.cedula }'),
            Text( 'Correo: ${ usuario.correo }' )
          ],
        ),
      ),
      
    );
  }
}