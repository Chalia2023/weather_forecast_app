import 'package:flutter/material.dart';

class WeatherStyles {
  // Title style for city name
  static const TextStyle cityTitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  // Style for today's date
  static const TextStyle todayDateStyle = TextStyle(
    fontSize: 25,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  // Style for tomorrow's date
  static const TextStyle tomorrowDateStyle = TextStyle(
    fontSize: 25,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  // Style for time point
  static const TextStyle timePointStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Style for weather condition
  static const TextStyle weatherConditionStyle = TextStyle(
    fontSize: 20,
    color: Colors.black87,
  );

  // Style for maximum temperature
  static const TextStyle maxTemperatureStyle = TextStyle(
    fontSize: 25,
    color: Colors.black87,
  );

  // Style for minimum temperature
  static const TextStyle minTemperatureStyle = TextStyle(
    fontSize: 25,
    color: Colors.black87,
  );

  // Style for rain probability
  static const TextStyle rainProbabilityStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  // Style for comfort level
  static const TextStyle comfortLevelStyle = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  // Button style for confirmation button
  static ButtonStyle confirmationButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.blueAccent),
  );

  // Icon for rain probability based on the probability value
  static IconData? getRainProbabilityIcon(double probability) {
    if (probability >= 70) {
      return Icons.beach_access;
    } else if (probability >= 30) {
      return Icons.umbrella;
    } else {
      return null;
    }
  }

  // Icon for weather condition based on the condition value
  static IconData getWeatherConditionIcon(String condition) {
    switch (condition) {
      case 'Rain':
        return Icons.grain;
      case 'Sunny':
        return Icons.wb_sunny;
      case 'Cloudy':
        return Icons.cloud;
      default:
        return Icons.help_outline;
    }
  }

  static IconData getWeatherIcon(
      String weatherCondition, double rainProbability) {
    if (weatherCondition == 'rainy' && rainProbability > 50) {
      return Icons.wb_sunny;
    }
    switch (weatherCondition) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'cloudy':
        return Icons.wb_cloudy;
      case 'rainy':
        return Icons.grain;
      default:
        return Icons.wb_sunny;
    }
  }
}
