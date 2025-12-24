import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  final provider = SalatTimesProvider();
  provider.setSalatTimes(todaySalatTimes);

  runApp(
    ChangeNotifierProvider(create: (context) => provider, child: NedaApp()),
  );
}
