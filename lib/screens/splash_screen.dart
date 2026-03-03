import 'dart:async';
import 'weather_screen.dart';
import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay 2 giây rồi chuyển màn hình
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WeatherScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E90FF),
              Color(0xFF87CEEB),
              Color(0xFFE3F2FD),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // ☀️ SUN (ở sau + lệch trái)
                    Positioned(
                      left: 80, // chỉnh lệch trái ở đây
                      top: 10,
                      child: Icon(
                        Icons.wb_sunny,
                        size: 150, // kích thước mặt trời
                        color: Colors.yellowAccent,
                        shadows: [
                          Shadow(
                            color: Colors.orange.withOpacity(0.8),
                            blurRadius: 60,
                          ),
                        ],
                      ),
                    ),

                    // ☁️ CLOUD (ở trước)
                    Icon(
                      Icons.cloud,
                      size: 130, // kích thước mây
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 25,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// CIRCULAR LOADING
            Positioned(
              top: 500,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
