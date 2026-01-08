part of '../main.dart';

Future<dynamic> bootstrap() async {
  /// db
  var db = DB('salat_times', await getApplicationDocumentsDirectory());
  var salatRepository = SalatRepository.of(db);

  /// blocs
  var salatTimesCubit = SalatTimesCubit(salatRepository: salatRepository);

  // First try to get from DB
  await salatTimesCubit.fetchTodaySalatTimeFromDb();

  // If no data in DB, fetch from API with current config
  if (salatTimesCubit.state == null) {
    var configBloc = ConfigBloc();

    // Wait a bit for config to initialize
    await Future.delayed(const Duration(milliseconds: 100));

    await salatTimesCubit.updateSalatTimesInDbFromApi(config: configBloc.state);

    // Fetch again from DB after update
    await salatTimesCubit.fetchTodaySalatTimeFromDb();
  }

  return {'salatTimesCubit': salatTimesCubit}; // Return the initialized cubit
}
