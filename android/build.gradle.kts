import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  double? temperature;
  double? windSpeed;
  bool loading = false;

  Future<void> fetchWeather() async {
    setState(() => loading = true);

    // Hà Nội (lat: 21.03, lon: 105.85)
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=21.03&longitude=105.85&current_weather=true';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    setState(() {
      temperature = data['current_weather']['temperature'];
      windSpeed = data['current_weather']['windspeed'];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌤 Weather App'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hà Nội',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              if (loading) const CircularProgressIndicator(),

              if (!loading && temperature != null) ...[
                Text(
                  '${temperature!.toStringAsFixed(1)} °C',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Gió: ${windSpeed!.toStringAsFixed(1)} km/h',
                  style: const TextStyle(fontSize: 18),
                ),
              ],

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: fetchWeather,
                child: const Text('Cập nhật thời tiết'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
