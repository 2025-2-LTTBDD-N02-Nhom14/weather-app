import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp là widget gốc
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Profile App',
      home: const HomeScreen(), // màn hình đầu tiên
    );
  }
}

// HomeScreen là màn hình đầu tiên, có thể là Login tạm thời
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Profile App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Auth Profile App',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // tạm thời in ra log
                print('Login button pressed!');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login pressed!')),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
