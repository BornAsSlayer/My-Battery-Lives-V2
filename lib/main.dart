import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Battery Lives',
      theme: ThemeData( 
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
