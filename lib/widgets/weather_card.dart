import 'dart:ui';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const WeatherCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.02),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (trailing != null)
                    IconTheme(
                      data: const IconThemeData(
                        color: Colors.white,
                      ),
                      child: trailing!,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.white,
                ),
                child: IconTheme(
                  data: const IconThemeData(
                    color: Colors.white,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
