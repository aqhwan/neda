import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:neda/screens/lib.dart';
import 'package:neda/screens/root/_shared/get_next_salat.dart';

class TimeList extends StatelessWidget {
  const TimeList({super.key});

  @override
  Widget build(BuildContext context) {
    Row prayerTimeLine(
      String salatName,
      TimeOfDay salatTime, [
      bool isNextSalat = false,
    ]) {
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
              color: isNextSalat
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<SalatTimesCubit, Salat?>(
          builder: (context, salatTimes) {
            if (salatTimes == null) return noDataFoundException(context);
            var nextSalat = getNextSalat(salatTimes);
            bool isNextSalat(String salatName) => nextSalat!.$2 == salatName;

            return Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: getSalatList(salatTimes)
                  .map((e) => prayerTimeLine(e.$2, e.$1, isNextSalat(e.$2)))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
