import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final salatProvider = SalatTimesProvider();
  await salatProvider.setSalatTimes(); // Add await

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {
      // Log to console or your logging service
      print('PRODUCTION: $message');
    };
  }

  runApp(ChangeNotifierProvider.value(value: salatProvider, child: NedaApp()));
}
