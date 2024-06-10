import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../configs/weather_styles.dart';
import '../providers/weather_provider.dart';
import '../utils/date_time_utils.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_handling.dart';

class HomePage extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('天氣預報'),
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 16, 16, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: '搜尋城市 (e.g.臺中市)',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (String value) {
                        ref.refresh(weatherProvider.notifier);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () async {
                      final enteredCity = _searchController.text;
                      if (enteredCity.isNotEmpty) {
                        await ref
                            .read(weatherProvider.notifier)
                            .fetchWeather(enteredCity);
                      }
                    },
                    style: WeatherStyles.confirmationButtonStyle,
                    child: const Text('確認'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (weatherState.isLoading) const LoadingIndicator(),
              if (weatherState.error != null && weatherState.error!.isNotEmpty)
                ErrorHandling(
                  errorMessage: weatherState.error!,
                ),
              if (weatherState.weatherData != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherState.weatherData!.locations.length,
                    itemBuilder: (context, index) {
                      final location =
                          weatherState.weatherData!.locations[index];
                      final wxElement = location.weatherElement
                          .firstWhere((element) => element.elementName == 'Wx');
                      final minTElement = location.weatherElement.firstWhere(
                          (element) => element.elementName == 'MinT');
                      final maxTElement = location.weatherElement.firstWhere(
                          (element) => element.elementName == 'MaxT');
                      final popElement = location.weatherElement.firstWhere(
                          (element) => element.elementName == 'PoP');
                      final ciElement = location.weatherElement
                          .firstWhere((element) => element.elementName == 'CI');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location.locationName,
                              style: WeatherStyles.cityTitleStyle,
                            ),
                            const SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i = 0; i < wxElement.time.length; i++)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (i == 0 || i == 1)
                                        Text(
                                          getTimeLabel(
                                              wxElement.time[i].startTime),
                                          style: WeatherStyles.todayDateStyle,
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // Wrap each date in a container
                                              decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                '${formatTime(wxElement.time[i].startTime)} - ${formatTime(wxElement.time[i].endTime)}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Row(
                                                        children: [
                                                          Icon(WeatherStyles
                                                              .getRainProbabilityIcon(
                                                                  double.parse(
                                                                      popElement
                                                                          .time[
                                                                              i]
                                                                          .parameter
                                                                          .parameterName))),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                            '降雨機率: ${popElement.time[i].parameter.parameterName}%',
                                                            style: WeatherStyles
                                                                .rainProbabilityStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Icon(WeatherStyles
                                                    .getWeatherIcon(
                                                        wxElement
                                                            .time[i]
                                                            .parameter
                                                            .parameterName,
                                                        double.parse(popElement
                                                            .time[i]
                                                            .parameter
                                                            .parameterName))),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${wxElement.time[i].parameter.parameterName} (${wxElement.time[i].parameter.parameterValue})',
                                                  style: WeatherStyles
                                                      .weatherConditionStyle,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${minTElement.time[i].parameter.parameterName}°C',
                                                    style: WeatherStyles
                                                        .minTemperatureStyle,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  flex: 1,
                                                  child:
                                                      LinearProgressIndicator(
                                                    backgroundColor:
                                                        Colors.grey[400],
                                                    value: (double.parse(minTElement
                                                                .time[i]
                                                                .parameter
                                                                .parameterName) -
                                                            0) /
                                                        (40 - 0),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    '${maxTElement.time[i].parameter.parameterName}°C',
                                                    style: WeatherStyles
                                                        .maxTemperatureStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                const Icon(Icons.mood),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '舒適度: ${ciElement.time[i].parameter.parameterName}',
                                                  style: WeatherStyles
                                                      .comfortLevelStyle,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
