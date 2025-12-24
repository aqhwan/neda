import 'package:flutter/material.dart';
import 'package:neda/lib.dart';

class TimeList extends StatelessWidget {
  const TimeList({super.key});

  @override
  Widget build(BuildContext context) {
    prayerTimeLine(String salatName, TimeOfDay salatTime) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(salatTime.asString(), style: TextStyle(fontSize: FontSize.medium)),
        Text(salatName, style: TextStyle(fontSize: FontSize.medium)),
      ],
    );

    return Scrollable(
      viewportBuilder: (context, offset) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
              prayerTimeLine('فجر', TimeOfDay(hour: 6, minute: 7)),
            ],
          ),
        );
      },
    );
  }
}
