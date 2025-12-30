import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:neda/screens/root/error.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  (TimeOfDay, String)? _getNextSalat(Salat salatTimes) {
    bool isNextSalatFound = false;

    final salatList = [
      (salatTimes.fajr, 'الفجر'),
      (salatTimes.sunrise, 'الشروق'),
      (salatTimes.dhuhr, 'الظهر'),
      (salatTimes.asr, 'العصر'),
      (salatTimes.maghrib, 'المغرب'),
      (salatTimes.isha, 'العشاء'),
    ];

    for (final salatTime in salatList) {
      if (!isNextSalatFound && salatTime.$1.isAfter(TimeOfDay.now())) {
        isNextSalatFound = true;
        return salatTime;
      }
    }

    // If no salat found for today, return first salat of next day
    return salatList.first;
  }

  @override
  Widget build(BuildContext context) {
    Salat? salatTimes = SalatTimesCubit().state;

    if (salatTimes == null) return noDataFoundException(context);

    final salatTime = _getNextSalat(salatTimes);

    return Center(
      child: SingleChildScrollView(
        child: Flex(
          direction: .vertical,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Text(
              (salatTime!.$1 - TimeOfDay.now()).asString(),
              style: TextStyle(
                fontSize: FontSize.large,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(salatTime.$2, style: TextStyle(fontSize: FontSize.huge)),
          ],
        ),
      ),
    );
  }
}
