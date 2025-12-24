import 'package:flutter/material.dart';
import 'package:neda/screens/root/root.dart';
import 'package:neda/lib.dart';

class NedaApp extends StatelessWidget {
  const NedaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neda',
      theme: NedaTheme.of(context).data,
      home: Scaffold(body: NedaRoot()),
    );
  }
}
