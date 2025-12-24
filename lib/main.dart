import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var nedaDB = DB('salat_times', await getApplicationDocumentsDirectory());
  var salatRepository = SalatRepository.of(nedaDB);

  var todaySalatTimes = salatRepository.getTodayPrayerTimes();

  if (todaySalatTimes == null) {
    var api = PrayerTimesApi(country: 'USK', city: 'mecca');
    var salatTimes = await api.fetchPrayerTimes();
    await salatRepository.overwriteAll(salatTimes);

    todaySalatTimes = salatRepository.getTodayPrayerTimes();
  }

  runApp(NedaApp());
}
