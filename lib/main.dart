import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:path_provider/path_provider.dart';

part 'blocs/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  runApp(NedaApp());
}
