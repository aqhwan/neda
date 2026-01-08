// config.dart - Make Config immutable
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Config {
  final double latitude;
  final double longitude;
  final int method;

  const Config({
    required this.latitude,
    required this.longitude,
    required this.method,
  });
}
