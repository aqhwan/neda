import 'package:flutter/material.dart';
import 'package:neda/lib.dart';

class NedaBottomSheet extends StatelessWidget {
  const NedaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .only(right: 10, left: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: .only(top: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: .only(
              topLeft: .circular(60),
              topRight: .circular(60),
            ),
          ),
          child: Column(
            children: [
              NedaMenuItimButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => _PlacePicker(),
                ),
              ),
            ],
          ), //TODO:
        ),
      ),
    );
  }
}

class _PlacePicker extends StatefulWidget {
  const _PlacePicker();

  @override
  State<_PlacePicker> createState() => _PlacePickerState();
}

class _PlacePickerState extends State<_PlacePicker> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: Container(
            padding: const .all(20),
            child: ElevatedButton(
              onPressed: () async {
                /* TODO: */
              },
              child: Text('read the current location'),
            ),
          ),
        ),
      ],
    );
  }
}
