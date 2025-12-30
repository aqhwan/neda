import 'package:flutter/material.dart';
import 'package:country_picker_flutter/country_picker_flutter.dart';
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
  final ConfigCubit configCubit = ConfigCubit();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: Container(
            padding: const .all(20),
            child: CountryPicker(
              showCities: true,
              flagState: .SHOW_IN_DROP_DOWN_ONLY,
              showStates: true,
              cityLanguage: .native,
              countryStateLanguage: .arabic,
              dropdownDecoration: BoxDecoration(
                borderRadius: const .all(.circular(10)),
                color: Theme.of(context).colorScheme.primary,
              ),
              disabledDropdownDecoration: .new(
                borderRadius: const .all(.circular(10)),
                color: Theme.of(context).colorScheme.primary,
              ),
              selectedItemStyle: .new(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 14,
              ),
              searchBarRadius: 20,
              dropdownHeadingStyle: .new(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 17,
                fontWeight: .bold,
              ),
              dropdownItemStyle: .new(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
              onCountryChanged: (value) {
                setState(() {
                  configCubit.writeConfig(country: value);
                });
              },
              onStateChanged: (value) {
                setState(() {});
              },
              onCityChanged: (value) {
                setState(() {
                  configCubit.writeConfig(city: value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
