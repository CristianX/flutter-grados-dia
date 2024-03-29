import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';

// Models
import 'package:grados_dia_app/src/models/hectarea_model.dart';

final PopupController _popupController = new PopupController();

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
              child: Icon( Icons.room, size: 80, color: Color.fromRGBO(76, 175, 80, 1.0) ),
            ),
          )
        );       
        // points.add(new LatLng( cultivo.hectarea.latitud , cultivo.hectarea.longitud));

    });



      return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(-0.771949, -78.598254),
        zoom: 9.5,
        plugins: [ MarkerClusterPlugin() ],
        onTap: ( _ ) => _popupController.hidePopup()
        // Esconder popup al dar click en cualquier punto del mapa
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoiY3Jpc3RpYW54bGQiLCJhIjoiY2thcmN1OTI1MDFnMjJ4bGVmcTRzOHgzciJ9.-snc-fT6vt1OVlB6OckqqQ',
            'id': 'mapbox.satellite',
          },
        ),
        new MarkerClusterLayerOptions(
          markers: markers,
          popupOptions: PopupOptions(
            popupSnap: PopupSnap.top,
            popupController: _popupController,
            popupBuilder: ( _, marker ) => Container(
              width: 200,
              height: 100,
              color: Colors.white,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(nombreHectarea(marker)),
                    Text('Latitud: ${ marker.point.latitude }'),
                    Text('Longitud: ${ marker.point.longitude }'),
                    // Botones
                    Row(
                      children: <Widget>[
                        RaisedButton(color: Colors.deepOrange, onPressed: (){},),
                        RaisedButton(color: Colors.green, onPressed: (){},),
                      ],
                    )
                  ],
                ),
              )
            )
          ),
          builder: (context, markers) => Icon( Icons.room, size: 80, color: Color.fromRGBO(76, 175, 80, 1.0) )
        )
      ],
    );
  }

  // Evaluando coordenadas para imprimir el nombre de la plantación
  String nombreHectarea( Marker marker ) {
    String nombreHectarea = 'Hectarea inexistente';
    this.hectareas.forEach((hectarea) {
      if( hectarea.latitud == marker.point.latitude && hectarea.longitud == marker.point.longitude ) {
        nombreHectarea = '${ hectarea.nombre }';
      }
    });
    return nombreHectarea;
  }

}