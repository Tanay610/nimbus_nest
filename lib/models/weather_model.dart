
import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final int currentPressure;
  final double currentWindSpeed;
  final int currentHumidity;
  final List<HourlyForecast> hourlyForecasts; 

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecasts
  });
  


  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    int? currentPressure,
    double? currentWindSpeed,
    int? currentHumidity,
    List<HourlyForecast>? hourlyForecasts,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity, 
      hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecasts': hourlyForecasts,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyList = List<Map<String, dynamic>>.from(map['hourly'] ?? []);
    final hourlyForecasts = hourlyList
        .map((hourlyData) => HourlyForecast.fromMap(hourlyData))
        .toList();
    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlyForecasts: hourlyForecasts

    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, hourlyForecasts: $hourlyForecasts)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentTemp == currentTemp &&
      other.currentSky == currentSky &&
      other.currentPressure == currentPressure &&
      other.currentWindSpeed == currentWindSpeed &&
      other.hourlyForecasts == hourlyForecasts&&
      other.currentHumidity == currentHumidity;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
      currentSky.hashCode ^
      currentPressure.hashCode ^
      currentWindSpeed.hashCode ^
      hourlyForecasts.hashCode^
      currentHumidity.hashCode;
  }
}




class HourlyForecast {
  final int timestamp; 
  final double temperature; // Temperature at the forecast time
  final String weatherDescription;// Icon representing the weather condition

  HourlyForecast({
    required this.timestamp,
    required this.temperature,
    required this.weatherDescription,
  });

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
     final currentWeatherData = map['list'][0];
    return HourlyForecast(
      timestamp: currentWeatherData['dt'],
      temperature: currentWeatherData['temp'],
      weatherDescription: currentWeatherData['weather'][0]['description'],
    );
  }
}