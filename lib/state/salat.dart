import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:path_provider/path_provider.dart';

class SalatTimesProvider extends ChangeNotifier {
  Salat? _salatTimes;

  Salat? get salatTimes => _salatTimes;

  Future<void> setSalatTimes() async {
    var nedaDB = DB('salat_times', await getApplicationDocumentsDirectory());
    var salatRepository = SalatRepository.of(nedaDB);

    var todaySalatTimes = await salatRepository.getTodayPrayerTimes();

    if (todaySalatTimes == null) {
      var api = PrayerTimesApi(
        country: 'USK',
        city: 'mecca',
      ); // TODO: change to your country and city

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
    }

    _salatTimes = todaySalatTimes;
    notifyListeners();
  }
}
