import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:grados_dia_app/src/models/cultivo_model.dart';
import 'package:latlong/latlong.dart';


class MapaCultivo extends StatelessWidget {

  final List<Cultivo> cultivos;

  const MapaCultivo(this.cultivos);

  @override
  Widget build(BuildContext context) {

    var markers = <Marker>[];

    this.cultivos.forEach((cultivo) {
      if( cultivo.hectarea != null ) {
        markers.add(
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(cultivo.hectarea.latitud, cultivo.hectarea.longitud),
            builder: (ctx) =>
            new Container(
              child: Icon( Icons.room, size: 80, )
            ),
          )
        ); 
            
        // points.add(new LatLng( cultivo.hectarea.latitud , cultivo.hectarea.longitud));
      }
    });



      return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(-0.9226977815149553, -78.61242028610867),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
            'id': 'mapbox.satellite',
          },
        ),
        new MarkerLayerOptions(
          markers: markers
        ),
      ],
    );
  }
}