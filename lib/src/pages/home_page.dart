import 'package:flutter/material.dart';

// Flutteter Map
import 'package:flutter_map/flutter_map.dart';
import 'package:grados_dia_app/src/models/cultivo_model.dart';

// Service
import 'package:grados_dia_app/src/services/cultivos_services.dart';
import 'package:grados_dia_app/src/widgets/maps_cultivos.dart';


// LatLong
import 'package:latlong/latlong.dart';

// Provider
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final cultivoService = Provider.of<CultivoService>(context);


    return Scaffold(

      body: MapaCultivo( cultivoService.cultivos )

    );

      // body: _Mapa()
  }
}

