import 'package:flutter/material.dart';
import 'package:neda/exports/pages.dart' show Root;

class NedaApp extends StatelessWidget {
  const NedaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نداء',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Root(),
    );
  }
}
