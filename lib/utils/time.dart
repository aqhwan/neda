import 'package:flutter/material.dart';

typedef Date = DateTime;

extension TimeAsString on TimeOfDay {
  String asString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  Duration get asDuration => Duration(hours: hour, minutes: minute);

  TimeOfDay operator -(TimeOfDay other) {
    var decreseHour = other.minute > minute;
    var otherHour = decreseHour ? other.hour + 1 : other.hour;
    var thisHour = hour < otherHour ? 24 + hour : hour;

    return TimeOfDay(
      hour: thisHour - otherHour,
      minute: (minute - other.minute) % 60,
    );
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

extension DateTimeAsString on DateTime {
  String asStringSeparatedByDash() {
    return [
      day.toString().padLeft(2, '0'),
      month.toString().padLeft(2, '0'),
      year.toString().padLeft(4, '0'),
    ].join('-');
  }
}
