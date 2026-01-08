import 'package:flutter/material.dart';
import 'package:neda/modele/salat.dart';

List<(TimeOfDay, String)> getSalatList(Salat salatTimes) {
  return [
    (salatTimes.fajr, 'الفجر'),
    (salatTimes.sunrise, 'الشروق'),
    (salatTimes.dhuhr, 'الظهر'),
    (salatTimes.asr, 'العصر'),
    (salatTimes.maghrib, 'المغرب'),
    (salatTimes.isha, 'العشاء'),
  ];
}

(TimeOfDay, String)? getNextSalat(Salat salatTimes) {
  bool isNextSalatFound = false;

  final List<(TimeOfDay, String)> salatList = getSalatList(salatTimes);

  for (final salatTime in salatList) {
    if (!isNextSalatFound && salatTime.$1.isAfter(TimeOfDay.now())) {
      isNextSalatFound = true;
      return salatTime;
    }
  }

  // If no salat found for today, return first salat of next day
  return salatList.first;
}
