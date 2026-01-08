import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalatTimesCubit extends Cubit<Salat?> {
  final SalatRepository salatRepository;

  SalatTimesCubit({required this.salatRepository}) : super(null);

  /// fetch the today salat times from the database
  Future<void> fetchTodaySalatTimeFromDb() async {
    var todaySalatTimes = await salatRepository.getTodayPrayerTimes();
    emit(todaySalatTimes);
  }

  /// refetch the salat times from the api and store them in the database
  Future<void> updateSalatTimesInDbFromApi({required Config config}) async {
    var api = PrayerTimesApi(config: config);

    List<Salat>? salatTimes;
    try {
      salatTimes = await api.fetchPrayerTimes();
    } catch (e) {
      debugPrint(e.toString());
    }

    if (salatTimes != null) {
      _writeSalatTimesToDb(salatTimes: salatTimes);
    }
  }

  /// refresh event handler
  Future<void> refresh({required Config config}) async {
    // Only update if coordinates are valid (not 0,0)
    if (config.latitude != 0 && config.longitude != 0) {
      await updateSalatTimesInDbFromApi(config: config);

      await fetchTodaySalatTimeFromDb();
    } else {
      throw Exception('No valid location');
    }
  }

  /// store the salat times in the database
  void _writeSalatTimesToDb({required List<Salat> salatTimes}) {
    salatRepository.overwriteAll(salatTimes);
  }
}
