import 'dart:convert';

import 'package:nimbus_nest/data/data_provider/weather_data_provider.dart';
import 'package:nimbus_nest/models/weather_model.dart';

class WeatherRepo{
  final WeatherDataProvider weatherDataProvider;

  WeatherRepo(this.weatherDataProvider);

    Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

  return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }

}