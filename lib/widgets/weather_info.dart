import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final dynamic weatherData;

  WeatherInfo(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Temperature: ${weatherData['main']['temp']}°C'),
        Text('Weather: ${weatherData['weather'][0]['description']}'),
        Text('Humidity: ${weatherData['main']['humidity']}%'),
      ],
    );
  }
}
