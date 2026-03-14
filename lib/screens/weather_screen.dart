import 'package:auth_profile_app/providers/weather_provider.dart';
import 'package:auth_profile_app/widgets/weather_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:auth_profile_app/models/weather_model.dart';
import 'package:auth_profile_app/services/weather_service.dart';
import 'package:auth_profile_app/widgets/weather_metric_card.dart';
import 'package:auth_profile_app/widgets/temperature_chart_card.dart';
import 'package:auth_profile_app/widgets/more_weather_day_card.dart';
import 'package:auth_profile_app/charts/temperature_chart.dart';
import 'package:auth_profile_app/screens/search_location_screen.dart';
import 'package:auth_profile_app/screens/location_screen.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late PageController _pageController;

  int currentIndex = 0;

  final Map<int, bool> _navbarState = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    Future.microtask(() {
      context.read<WeatherProvider>().loadDefaultAddress();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cities = Provider.of<WeatherProvider>(context).cities;
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: cities.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final scrollController = ScrollController();
                  final data = cities[index];

                  _navbarState.putIfAbsent(index, () => true);

                  scrollController.addListener(() {
                    if (scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                      if (_navbarState[index] == true) {
                        setState(() {
                          _navbarState[index] = false;
                        });
                      }
                    }

                    if (scrollController.position.userScrollDirection ==
                        ScrollDirection.forward) {
                      if (_navbarState[index] == false) {
                        setState(() {
                          _navbarState[index] = true;
                        });
                      }
                    }
                  });

                  final List<HourlyForecast> hourlyData =
                      data.twentyFourHourForecast.map<HourlyForecast>((e) {
                    return HourlyForecast(
                      time: e.time,
                      feelsLike: e.feelsLike.toDouble(),
                      cloudCover: data.currentWeather.cloudCover,
                      humidity: data.currentWeather.humidity,
                      uvIndex: data.currentWeather.uvIndex,
                    );
                  }).toList();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 20),
                        child: Text(
                          data.location.city,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                WeatherOverviewCard(
                                  temperature:
                                      "${data.currentWeather.temperature}°",
                                  description:
                                      data.currentWeather.weatherDescription,
                                  maxTemp:
                                      "${data.currentWeather.maxTemperature.round()}°",
                                  minTemp:
                                      "${data.currentWeather.minTemperature.round()}°",
                                  feelsLike:
                                      "${data.currentWeather.feelsLike.round()}°",
                                ),
                                ChartTemperatureCard(hourlyData: hourlyData),
                                const SizedBox(height: 20),
                                MoreSevenDayCard(data: data),
                                const SizedBox(height: 20),
                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  children: [
                                    WeatherMetricCard(
                                      title: loc.tr('temperature'),
                                      value:
                                          "${data.currentWeather.temperature}°C",
                                      icon: Icons.thermostat,
                                    ),
                                    WeatherMetricCard(
                                      title: loc.tr('description'),
                                      value: data
                                          .currentWeather.weatherDescription,
                                      icon: Icons.cloud,
                                    ),
                                    WeatherMetricCard(
                                      title: loc.tr('humidity'),
                                      value: "${data.currentWeather.humidity}%",
                                      icon: Icons.water_drop,
                                    ),
                                    WeatherMetricCard(
                                      title: loc.tr('wind'),
                                      value:
                                          "${data.currentWeather.wind.speed} ${data.currentWeather.wind.unit}",
                                      icon: Icons.air,
                                    ),
                                    WeatherMetricCard(
                                      title: loc.tr('uv'),
                                      value: "${data.currentWeather.uvIndex}",
                                      icon: Icons.wb_sunny,
                                    ),
                                    WeatherMetricCard(
                                      title: loc.tr('pressure'),
                                      value:
                                          "${data.currentWeather.pressure} hPa",
                                      icon: Icons.speed,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: (_navbarState[currentIndex] ?? true) ? 80 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: (_navbarState[currentIndex] ?? true) ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LocationScreen(),
                                  ),
                                );

                                if (result != null && result is int) {
                                  _pageController.animateToPage(
                                    result,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(cities.length, (i) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentIndex == i ? 12 : 8,
                              height: currentIndex == i ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == i
                                    ? Colors.white
                                    : Colors.white54,
                              ),
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: IconButton(
                              icon:
                                  const Icon(Icons.search, color: Colors.white),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const SearchLocationScreen(),
                                  ),
                                );

                                if (result != null && result is WeatherModel) {
                                  Provider.of<WeatherProvider>(context,
                                          listen: false)
                                      .addCity(result);
                                  _pageController.jumpToPage(cities.length - 1);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
