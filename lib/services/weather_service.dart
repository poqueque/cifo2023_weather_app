import 'package:http/http.dart' as http;

import '../models/meteo.dart';

class WeatherService {
  static const latitude = 41.358889;
  static const longitude = 2.099167;

  Future<Meteo> fetchData() async {
    var response = await http.get(Uri.parse(
        "http://www.7timer.info/bin/api.pl?lon=$longitude&lat=$latitude&product=civil&output=json"));
    final meteo = meteoFromJson(response.body);
    return meteo;
  }
}
