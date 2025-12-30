import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
part 'state/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  runApp(NedaApp());
}
