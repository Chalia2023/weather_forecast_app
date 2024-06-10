import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CitySearchPage extends StatelessWidget {
  final List<String> cities = [
    '宜蘭縣',
    '花蓮縣',
    '臺東縣',
    '澎湖縣',
    '金門縣',
    '連江縣',
    '臺北市',
    '新北市',
    '桃園市',
    '臺中市',
    '臺南市',
    '高雄市',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search City'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final city = cities[index];
          return ListTile(
            title: Text(city),
            onTap: () {
              context.read().fetchWeather(city);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
