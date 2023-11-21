import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/meteo.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget(
      {super.key, required this.dataSerie, required this.reference});

  final DataSerie dataSerie;
  final DateTime reference;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var instantDate = reference.add(Duration(hours: dataSerie.timepoint));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: width * 0.4,
          child: Text(
            "Dia ${DateFormat("dd\nHH:mm").format(instantDate)}",
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: width * 0.2,
          child: Icon(
            dataSerie.iconData,
            size: 36,
          ),
        ),
        SizedBox(
          width: width * 0.4,
          child: Text(
            "${dataSerie.temp2M}º C",
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
