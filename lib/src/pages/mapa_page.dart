import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:grados_dia_app/src/services/hectarea_service.dart';

// Widgets
import 'package:grados_dia_app/src/widgets/maps_hectareas.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Llamando service
    final hectareaService = Provider.of<HectareaService>(context);

    return Scaffold(

      body: MapaHectarea( hectareaService.hectareas ),
      
    );
  }
}