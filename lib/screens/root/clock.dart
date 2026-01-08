import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:neda/screens/root/_shared/get_next_salat.dart';
import 'package:neda/screens/root/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<SalatTimesCubit, Salat?>(
          builder: (context, state) {
            if (state == null) return noDataFoundException(context);

            final salatTime = getNextSalat(state);

            return Flex(
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
            );
          },
        ),
      ),
    );
  }
}
