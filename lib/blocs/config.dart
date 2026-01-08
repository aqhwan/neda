import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neda/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Config defaultConfig = Config(latitude: 0, longitude: 0, method: 0);

class ConfigBloc extends Bloc<ConfigEvent, Config> {
  late final SharedPreferences prefs;

  get _method => prefs.getInt('method') ?? defaultConfig.method;

  ConfigBloc() : super(defaultConfig) {
    on<ConfigEvent>((event, emit) async {
      switch (event) {
        case UpdateLocationEvent():
          if (!await isLocationServiceEnabled()) {
            throw Exception('Location service is not enabled');
          }

          await makeSurePermissionIsGranted();

          var position = await _updateLocation();

          emit(
            Config(
              latitude: position.latitude,
              longitude: position.longitude,
              method: _method,
            ),
          );

          break;
        case UpdateMethodEvent():
          await _updateMethod(event.method);
          emit(
            Config(
              latitude: state.latitude,
              longitude: state.longitude,
              method: event.method,
            ),
          );
          break;
      }
    });

    // Initialize after setting up event handlers
    _init();
  }

  Future<bool> isLocationServiceEnabled() async =>
      await Geolocator.isLocationServiceEnabled();

  Future<void> makeSurePermissionIsGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
  }

  //- custom event handlers

  // void onUpdate(Function callback) {
  //   on<ConfigEvent>((event, _) async {
  //     if (event == .update) {
  //       callback();
  //     }
  //   });
  // }

  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');

    // Only emit if we have stored values
    if (latitude != null && longitude != null) {
      add(UpdateLocationEvent());
    }
  }

  //- event handlers
  Future<Position> _updateLocation() async {
    var position = await Geolocator.getCurrentPosition();

    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);

    return position;
  }

  Future<void> _updateMethod(int method) async {
    await prefs.setInt('method', method);
  }
}

sealed class ConfigEvent {}

final class UpdateLocationEvent extends ConfigEvent {}

final class UpdateMethodEvent extends ConfigEvent {
  final int method;
  UpdateMethodEvent(this.method);
}
