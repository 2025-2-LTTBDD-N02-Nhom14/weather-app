import 'package:auth_profile_app/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:auth_profile_app/screens/search_location_screen.dart';
import 'package:auth_profile_app/widgets/location_card.dart';
import 'package:auth_profile_app/models/weather_model.dart';
import 'package:provider/provider.dart';
import 'package:auth_profile_app/screens/setting_screen.dart';
import 'package:auth_profile_app/localization/app_localizations.dart';
import 'package:auth_profile_app/providers/languague_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isSelectionMode = false;
  Set<WeatherModel> selectedCities = {};

  @override
  Widget build(BuildContext context) {
    final cities = Provider.of<WeatherProvider>(context).cities;
    final languageProvider = context.watch<LanguageProvider>();

    final loc = AppLocalizations.of(context);
    void toggleSelectAll() {
      setState(() {
        if (selectedCities.length == cities.length) {
          selectedCities.clear();
        } else {
          selectedCities = cities.toSet();
        }
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      bottomNavigationBar: isSelectionMode
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: Colors.grey,
              child: SafeArea(
                child: Material(
                  child: InkWell(
                    splashColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade200,
                    onTap: selectedCities.isEmpty
                        ? null
                        : () {
                            setState(() {
                              for (var city in selectedCities) {
                                Provider.of<WeatherProvider>(context,
                                        listen: false)
                                    .removeCity(city);
                              }
                              selectedCities.clear();
                              isSelectionMode = false;
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 26,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selectedCities.length == cities.length
                                ? loc.tr('delete_all')
                                : loc.tr('delete'),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (!isSelectionMode)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        loc.tr('weather'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchLocationScreen(),
                          ),
                        );

                        if (result != null && result is WeatherModel) {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .addCity(result);
                        }
                      },
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: PopupMenuButton<String>(
                        constraints: const BoxConstraints(
                          minWidth: 180,
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == "chon") {
                            setState(() {
                              isSelectionMode = true;
                            });
                          }

                          if (value == "cai_dat") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingScreen(),
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "chon",
                            child: Text(loc.tr('select')),
                          ),
                          PopupMenuItem(
                            value: "cai_dat",
                            child: Text(loc.tr('setting')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: toggleSelectAll,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Icon(
                                selectedCities.length == cities.length &&
                                        cities.isNotEmpty
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: selectedCities.length == cities.length &&
                                        cities.isNotEmpty
                                    ? Colors.blue
                                    : Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                loc.tr('all'),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(width: 16),
                    Text(
                      selectedCities.isEmpty
                          ? loc.tr('select_location')
                          : loc.tr('selected') + "${selectedCities.length}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSelectionMode = false;
                          selectedCities.clear();
                        });
                      },
                      child: Text(
                        loc.tr('cancel'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cities.isEmpty ? 1 : cities.length,
                itemBuilder: (context, index) {
                  if (cities.isEmpty) {
                    return GestureDetector(
                      onTap: () async {
                        final weather = await context
                            .read<WeatherProvider>()
                            .loadDefaultAddress();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ]),
                        child: Center(
                          child: Text(
                            loc.tr('add_current_location'),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final weather = cities[index];
                  final isSelected = selectedCities.contains(weather);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        if (isSelectionMode)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedCities.remove(weather);
                                  } else {
                                    selectedCities.add(weather);
                                  }
                                });
                              },
                              child: Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: isSelected ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                        Expanded(
                          child: LocationCard(
                            city: weather.location.city,
                            country: weather.location.country,
                            temperature: weather.currentWeather.temperature,
                            minTemp: weather.currentWeather.minTemperature,
                            maxTemp: weather.currentWeather.maxTemperature,
                            description:
                                weather.currentWeather.weatherDescription,
                            time: DateTime.now(),
                            onTap: () {
                              Navigator.pop(context, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
