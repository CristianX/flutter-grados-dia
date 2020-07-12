import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:grados_dia_app/src/models/data_grafico_model.dart';


class GraficaLinear extends StatelessWidget {

  final List<charts.Series<DataGrafico, DateTime>> _seriesLinearData;

  const GraficaLinear( this._seriesLinearData );

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      _seriesLinearData,
      animate: true,
      animationDuration: Duration( seconds: 1 ),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'd',
            transitionFormat: 'MM/dd/yyyy'
          )
        )
      ),
    );
  }
}