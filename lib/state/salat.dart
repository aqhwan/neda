import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalatTimesCubit extends Cubit<Salat?> {
  SalatTimesCubit() : super(null);

  Future<void> setSalatTimes(Config config) async {
    var configCubit = ConfigCubit();
    configCubit.stream.listen((cfg) => print(cfg.oldCountry));
    var nedaDB = DB('salat_times', await getApplicationDocumentsDirectory());
    var salatRepository = SalatRepository.of(nedaDB);

    var todaySalatTimes = await salatRepository.getTodayPrayerTimes();

    if (todaySalatTimes == null ||
        (config.oldCountry != config.country ||
            config.oldCity != config.city)) {
      var api = PrayerTimesApi(country: config.country!, city: config.city!);

      List<Salat>? salatTimes;
      try {
        salatTimes = await api.fetchPrayerTimes();
      } catch (e) {
        debugPrint(e.toString());
      }

      if (salatTimes != null) {
        await salatRepository.overwriteAll(salatTimes);

        todaySalatTimes = await salatRepository.getTodayPrayerTimes();
      }

      configCubit.writeConfig(oldCountry: config.country, oldCity: config.city);
    }

    emit(todaySalatTimes);
  }
}
