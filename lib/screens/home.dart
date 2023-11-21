import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/meteo.dart';
import '../widgets/forecast_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    Future<Meteo> meteoFuture = WeatherService().fetchData();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
        ),
        body: FutureBuilder(
          future: meteoFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var meteo = snapshot.data!;
              return ListView(
                children: meteo.dataseries
                    .map((e) => ForecastWidget(
                          dataSerie: e,
                          reference: meteo.initDateTime,
                        ))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error getting data"),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ));
  }
}
