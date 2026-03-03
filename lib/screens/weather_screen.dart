import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> locations = ["Hà Nội"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newLocation =
                  await Navigator.pushNamed(context, '/add-location');

              if (newLocation != null) {
                setState(() {
                  locations.add(newLocation as String);
                });
              }
            },
          ),
        ],
      ),

      // 🔥 PageView vuốt ngang
      body: PageView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              "${locations[index]}\n28°C",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            ),
          );
        },
      ),
    );
  }
}