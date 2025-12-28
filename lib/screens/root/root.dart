import 'package:flutter/material.dart';
import 'package:neda/screens/root/clock.dart';
import 'package:neda/screens/root/time_list.dart';

class NedaRoot extends StatelessWidget {
  const NedaRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 40,
            left: 20,
            right: 20,
          ),
          child: Flex(
            direction: .vertical,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 20,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: .infinity,
                  height: .infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: .circular(20),
                  ),
                  child: Clock(),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: .infinity,
                  height: .infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: .circular(20),
                  ),
                  child: TimeList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
