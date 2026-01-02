import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalatTimesCubit extends Cubit<Salat?> {
  SalatTimesCubit() : super(null);

  /// fetch the today salat times from the database
  Future<void> fetchTodaySalatTimeFromDb({
    required SalatRepository salatRepository,
  }) async {
    var todaySalatTimes = await salatRepository.getTodayPrayerTimes();
    emit(todaySalatTimes);
  }

  /// refetch the salat times from the api and store them in the database
  Future<void> updateSalatTimesInDbFromApi({
    required Config config,
    required SalatRepository salatRepository,
  }) async {
    var api = PrayerTimesApi(config: config);

    List<Salat>? salatTimes;
    try {
      salatTimes = await api.fetchPrayerTimes();
    } catch (e) {
      debugPrint(e.toString());
    }

    if (salatTimes != null) {
      _writeSalatTimesToDb(
        salatRepository: salatRepository,
        salatTimes: salatTimes,
      );
    }
  }

  /// store the salat times in the database
  void _writeSalatTimesToDb({
    required SalatRepository salatRepository,
    required List<Salat> salatTimes,
  }) {
    salatRepository.overwriteAll(salatTimes);
  }
}
