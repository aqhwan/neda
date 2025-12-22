import 'package:flutter/material.dart';

typedef Date = DateTime;

class Salat {
  final Date date;
  final TimeOfDay fajr;
  final TimeOfDay sunrise;
  final TimeOfDay dhuhr;
  final TimeOfDay asr;
  final TimeOfDay maghrib;
  final TimeOfDay isha;

  Salat({
    required this.date,
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
}
