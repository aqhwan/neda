import 'package:flutter/material.dart';

typedef Date = DateTime;

extension TimeAsString on TimeOfDay {
  String asString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

extension ForatDuration on Duration {
  String get hoursAndMinutesFormatAsString {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
