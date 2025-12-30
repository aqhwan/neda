import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:neda/screens/lib.dart';

class TimeList extends StatelessWidget {
  const TimeList({super.key});

  @override
  Widget build(BuildContext context) {
    var isNextSalatSeted = false;

    prayerTimeLine(String salatName, TimeOfDay salatTime) {
      bool isNextSalat =
          !isNextSalatSeted && salatTime.isAfter(TimeOfDay.now());

      if (isNextSalat && !isNextSalatSeted) isNextSalatSeted = true;

      return Row(
        mainAxisAlignment: .spaceAround,
        mainAxisSize: .max,
        children: [
          Text(
            salatTime.asString(),
            style: TextStyle(fontSize: FontSize.medium),
          ),
          Text(
            salatName,
            style: TextStyle(
              fontSize: FontSize.medium,
              color: isNextSalat && isNextSalatSeted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      );
    }

    Salat? salatTimes = SalatTimesCubit().state;
    SalatTimesCubit().stream.listen(print);

    if (salatTimes != null) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              prayerTimeLine('فجر', salatTimes.fajr),
              prayerTimeLine('شروق', salatTimes.sunrise),
              prayerTimeLine('ظهر', salatTimes.dhuhr),
              prayerTimeLine('عصر', salatTimes.asr),
              prayerTimeLine('مغرب', salatTimes.maghrib),
              prayerTimeLine('عشاء', salatTimes.isha),
            ],
          ),
        ),
      );
    } else {
      return noDataFoundException(context);
    }
  }
}
