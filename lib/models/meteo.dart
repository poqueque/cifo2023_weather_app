// To parse this JSON data, do
//
//     final meteo = meteoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

Meteo meteoFromJson(String str) => Meteo.fromJson(json.decode(str));

String meteoToJson(Meteo data) => json.encode(data.toJson());

class Meteo {
  String product;
  String init;
  List<DataSerie> dataseries;

  DateTime get initDateTime {
    //20120227T132700
    //2012022713
    return DateTime.parse("${init.substring(0, 8)}T${init.substring(8)}0000");
  }

  Meteo({
    required this.product,
    required this.init,
    required this.dataseries,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) => Meteo(
        product: json["product"],
        init: json["init"],
        dataseries: List<DataSerie>.from(
            json["dataseries"].map((x) => DataSerie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "init": init,
        "dataseries": List<dynamic>.from(dataseries.map((x) => x.toJson())),
      };
}

class DataSerie {
  int timepoint;
  int cloudcover;
  int liftedIndex;
  PrecType precType;
  int precAmount;
  int temp2M;
  String rh2M;
  Wind10M wind10M;
  String weather;

  IconData get iconData {
    return switch (weather) {
      'clearday' => WeatherIcons.day_sunny,
      'pcloudyday' => WeatherIcons.day_cloudy,
      'mcloudyday' => WeatherIcons.cloud,
      'cloudyday' => WeatherIcons.cloudy,
      'humidday' => WeatherIcons.humidity,
      'lightrainday' => WeatherIcons.sprinkle,
      'oshowerday' => WeatherIcons.showers,
      'ishowerday' => WeatherIcons.rain,
      'lightsnowday' => WeatherIcons.sleet,
      'rainday' => WeatherIcons.rain,
      'snowday' => WeatherIcons.snow,
      'rainsnowday' => WeatherIcons.rain_mix,
      'tsday' => WeatherIcons.storm_showers,
      'tsrainday' => WeatherIcons.thunderstorm,
      'clearnight' => WeatherIcons.night_clear,
      'pcloudynight' => WeatherIcons.night_cloudy,
      'mcloudynight' => WeatherIcons.cloud,
      'cloudynight' => WeatherIcons.cloudy,
      'humidnight' => WeatherIcons.humidity,
      'lightrainnight' => WeatherIcons.sprinkle,
      'oshowernight' => WeatherIcons.showers,
      'ishowernight' => WeatherIcons.rain,
      'lightsnownight' => WeatherIcons.sleet,
      'rainnight' => WeatherIcons.rain,
      'snownight' => WeatherIcons.snow,
      'rainsnownight' => WeatherIcons.rain_mix,
      'tsnight' => WeatherIcons.storm_showers,
      'tsrainnight' => WeatherIcons.thunderstorm,
      _ => WeatherIcons.humidity,
    };
  }

  DataSerie({
    required this.timepoint,
    required this.cloudcover,
    required this.liftedIndex,
    required this.precType,
    required this.precAmount,
    required this.temp2M,
    required this.rh2M,
    required this.wind10M,
    required this.weather,
  });

  factory DataSerie.fromJson(Map<String, dynamic> json) => DataSerie(
        timepoint: json["timepoint"],
        cloudcover: json["cloudcover"],
        liftedIndex: json["lifted_index"],
        precType: precTypeValues.map[json["prec_type"]]!,
        precAmount: json["prec_amount"],
        temp2M: json["temp2m"],
        rh2M: json["rh2m"],
        wind10M: Wind10M.fromJson(json["wind10m"]),
        weather: json["weather"],
      );

  Map<String, dynamic> toJson() => {
        "timepoint": timepoint,
        "cloudcover": cloudcover,
        "lifted_index": liftedIndex,
        "prec_type": precTypeValues.reverse[precType],
        "prec_amount": precAmount,
        "temp2m": temp2M,
        "rh2m": rh2M,
        "wind10m": wind10M.toJson(),
        "weather": weather,
      };
}

enum PrecType { NONE, RAIN }

final precTypeValues =
    EnumValues({"none": PrecType.NONE, "rain": PrecType.RAIN});

class Wind10M {
  String direction;
  int speed;

  Wind10M({
    required this.direction,
    required this.speed,
  });

  factory Wind10M.fromJson(Map<String, dynamic> json) => Wind10M(
        direction: json["direction"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "speed": speed,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
