import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neda/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Config defaultConfig = Config(latitude: 0, longitude: 0);

class ConfigBloc extends Bloc<ConfigEvent, Config> {
  late final SharedPreferences prefs;

  ConfigBloc() : super(defaultConfig) {
    _init();

    on<ConfigEvent>((event, emit) async {
      switch (event) {
        case ConfigEvent.update:
          var position = await _update();

          emit(
            Config(latitude: position.latitude, longitude: position.longitude),
          );

          break;
      }
    });
  }

  Future<bool> isLocationServiceEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<void> makeSurePermissionIsGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }

  //- custom event handlers

  void onUpdate(Function callback) {
    on<ConfigEvent>((event, _) async {
      if (event == .update) {
        callback();
      }
    });
  }

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();

    final latitude = prefs.getDouble('latitude') ?? 0;
    final longitude = prefs.getDouble('longitude') ?? 0;

    // ignore: invalid_use_of_visible_for_testing_member
    emit(Config(latitude: latitude, longitude: longitude));
  }

  //- event handlers
  Future<Position> _update() async {
    var position = await Geolocator.getCurrentPosition();

    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);

    return position;
  }
}

enum ConfigEvent { update }
