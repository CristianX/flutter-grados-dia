import 'package:flutter/material.dart';

// Flutteter Map
import 'package:flutter_map/flutter_map.dart';
import 'package:grados_dia_app/src/models/cultivo_model.dart';

// Service
import 'package:grados_dia_app/src/services/cultivos_services.dart';


// LatLong
import 'package:latlong/latlong.dart';

// Provider
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final cultivoService = Provider.of<CultivoService>(context);


    return Scaffold(

      body: ListView.builder(
        itemCount: cultivoService.cultivos.length,
        itemBuilder: (BuildContext context, int index) {
        return Text( cultivoService.cultivos[index].id );
       },
      ),

    );

      // body: _Mapa()
  }
}

// class _Mapa extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//       return new FlutterMap(
//       options: new MapOptions(
//         center: new LatLng(51.5, -0.09),
//         zoom: 13.0,
//       ),
//       layers: [
//         new TileLayerOptions(
//           urlTemplate: "https://api.tiles.mapbox.com/v4/"
//               "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//           additionalOptions: {
//             'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
//             'id': 'mapbox.streets',
//           },
//         ),
//         new MarkerLayerOptions(
//           markers: [
//             new Marker(
//               width: 80.0,
//               height: 80.0,
//               point: new LatLng(51.5, -0.09),
//               builder: (ctx) =>
//               new Container(
//                 child: new FlutterLogo(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }