import 'package:dio/dio.dart';

void fetchWeatherData() async {
  try {
    Dio dio = Dio();
    String apiKey = 'CWA-A368513C-4524-49FD-87AC-523869937A23';
    Response response = await dio.get(
      'https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-C0032-001',
      queryParameters: {
        'Authorization': apiKey,
      },
    );
  } catch (error) {
    print('Error fetching weather data: $error');
  }
}
