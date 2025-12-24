import 'package:flutter/material.dart';
import 'package:neda/lib.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<StatefulWidget> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '٤٤د',
          style: TextStyle(
            fontSize: FontSize.large,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text('الفجر', style: TextStyle(fontSize: FontSize.huge)),
      ],
    );
  }
}
