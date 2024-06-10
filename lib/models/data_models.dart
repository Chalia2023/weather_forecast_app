class WeatherData {
  final String cityName;
  final List<Location> locations;

  WeatherData({required this.cityName, required this.locations});

  factory WeatherData.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherData(
      cityName: cityName,
      locations: (json['records']['location'] as List)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList(),
    );
  }

  static WeatherData fromResult(Result result, String cityName) {
    return WeatherData(
      cityName: cityName,
      locations: result.records,
    );
  }
}

class WeatherForecastResponse {
  final Result result;

  WeatherForecastResponse({required this.result});

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    return WeatherForecastResponse(
      result: Result.fromJson(json['records']),
    );
  }
}

class Result {
  final List<Location> records;

  Result({required this.records});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      records: (json['location'] as List)
          .map((locationJson) => Location.fromJson(locationJson))
          .toList(),
    );
  }
}

class Location {
  final String locationName;
  final List<WeatherElement> weatherElement;

  Location({required this.locationName, required this.weatherElement});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationName: json['locationName'],
      weatherElement: (json['weatherElement'] as List)
          .map((weatherElementJson) =>
              WeatherElement.fromJson(weatherElementJson))
          .toList(),
    );
  }
}

class WeatherElement {
  final String elementName;
  final List<Time> time;

  WeatherElement({required this.elementName, required this.time});

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    return WeatherElement(
      elementName: json['elementName'],
      time: (json['time'] as List)
          .map((timeJson) => Time.fromJson(timeJson))
          .toList(),
    );
  }
}

class Time {
  final String startTime;
  final String endTime;
  final Parameter parameter;

  Time(
      {required this.startTime,
      required this.endTime,
      required this.parameter});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      startTime: json['startTime'],
      endTime: json['endTime'],
      parameter: Parameter.fromJson(json['parameter']),
    );
  }
}

class Parameter {
  final String parameterName;
  final String? parameterValue;
  final String? parameterUnit;

  Parameter(
      {required this.parameterName, this.parameterValue, this.parameterUnit});

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      parameterName: json['parameterName'],
      parameterValue: json['parameterValue'],
      parameterUnit: json['parameterUnit'],
    );
  }
}
