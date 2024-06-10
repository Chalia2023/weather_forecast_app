import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/data_models.dart';

final weatherProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>((ref) {
  return WeatherNotifier();
});

class WeatherState {
  final bool isLoading;
  final WeatherData? weatherData;
  final String? error;
  final bool searchPerformed;

  WeatherState({
    this.isLoading = false,
    this.weatherData,
    this.error,
    this.searchPerformed = false,
  });

  WeatherState copyWith({
    bool? isLoading,
    WeatherData? weatherData,
    String? error,
    bool? searchPerformed,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      weatherData: weatherData ?? this.weatherData,
      error: error ?? this.error,
      searchPerformed: searchPerformed ?? this.searchPerformed,
    );
  }
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState());

  Future<void> fetchWeather(String city) async {
    if (kDebugMode) {
      print('Fetching weather data for city: $city');
    }
    state = state.copyWith(isLoading: true, searchPerformed: true);

    String apiKey = 'CWA-A368513C-4524-49FD-87AC-523869937A23';

    try {
      final response = await Dio().get(
        'https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-C0032-001',
        queryParameters: {
          'Authorization': apiKey,
          'locationName': city,
        },
      );

      if (response.statusCode == 200) {
        final weatherResponse = WeatherForecastResponse.fromJson(response.data);
        final weatherData =
            WeatherData.fromResult(weatherResponse.result, city);

        if (weatherData.locations.isEmpty) {
          setError('找不到該城市');
          state = state.copyWith(isLoading: false, weatherData: null);
        } else {
          clearError();
          state = state.copyWith(isLoading: false, weatherData: weatherData);
        }
      } else {
        setError('Failed to fetch weather data: ${response.statusMessage}');
        state = state.copyWith(isLoading: false, weatherData: null);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError fetching weather data: $e');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        setError('Connection Timeout Exception');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        setError('Receive Timeout Exception');
      } else {
        setError('Failed to fetch weather data: ${e.message}');
      }
      state = state.copyWith(isLoading: false, weatherData: null);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather data: $e');
      }
      setError('Failed to fetch weather data: $e');
      state = state.copyWith(isLoading: false, weatherData: null);
    }
  }

  void setError(String errorMessage) {
    if (kDebugMode) {
      print('Setting error: $errorMessage');
    }
    state = state.copyWith(error: errorMessage);
  }

  void clearError() {
    if (kDebugMode) {
      print('Clearing error');
    }
    state = state.copyWith(error: null);
  }
}
