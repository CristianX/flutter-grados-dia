import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

// Models
import 'package:grados_dia_app/src/models/hectarea_model.dart';


class MapaHectarea extends StatelessWidget {

  final List<Hectarea> hectareas;

  const MapaHectarea(this.hectareas);

  @override
  Widget build(BuildContext context) {

    var markers = <Marker>[];

    this.hectareas.forEach((hectarea) {
        markers.add(
          new Marker(
            width: 80.0,
            height: 80.0,
            point: new LatLng(hectarea.latitud, hectarea.longitud),
            builder: (ctx) =>
            new Container(
              child: Icon( Icons.room, size: 80, color: Color.fromRGBO(76, 175, 80, 1.0) )
            ),
          )
        ); 
            
        // points.add(new LatLng( cultivo.hectarea.latitud , cultivo.hectarea.longitud));

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