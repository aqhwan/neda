import 'package:flutter/material.dart';
import 'package:neda/screens/root/root.dart';

class NedaApp extends StatelessWidget {
  const NedaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neda',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NedaRoot(),
    );
  }
}
