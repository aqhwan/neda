import 'package:neda/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final Config defaultConfig = Config(country: 'USK', city: 'mecca');

class ConfigCubit extends Cubit<Config> {
  late final SharedPreferences prefs;

  ConfigCubit() : super(defaultConfig) {
    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    var config = Config(
      country: prefs.getString('country') ?? defaultConfig.country,
      city: prefs.getString('city') ?? defaultConfig.city,
      oldCountry: prefs.getString('oldCountry') ?? defaultConfig.country,
      oldCity: prefs.getString('oldCity') ?? defaultConfig.city,
    );

    emit(config);
  }

  Future<void> writeConfig({
    String? country,
    String? city,
    String? oldCountry,
    String? oldCity,
  }) async {
    var newState = state;

    if (country != null) {
      await prefs.setString('country', country);
      newState.country = country;
      emit(newState);
    }

    if (city != null) {
      await prefs.setString('city', city);
      newState.city = city;
      emit(newState);
    }

    if (oldCountry != null) {
      await prefs.setString('oldCountry', oldCountry);
      newState.oldCountry = oldCountry;
      emit(newState);
    }

    if (oldCity != null) {
      await prefs.setString('oldCity', oldCity);
      newState.oldCity = oldCity;
      emit(newState);
    }
  }
}
