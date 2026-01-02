part of '../main.dart';

Future<void> bootstrap() async {
  // db
  var db = DB('salat_times', await getApplicationDocumentsDirectory());
  var salatRepository = SalatRepository.of(db);

  // blocs
  var salatTimesCubit = SalatTimesCubit();
  var configBloc = ConfigBloc();

  salatTimesCubit.fetchTodaySalatTimeFromDb(salatRepository: salatRepository);

  if (salatTimesCubit.state == null) {
    salatTimesCubit.updateSalatTimesInDbFromApi(
      config: configBloc.state,
      salatRepository: salatRepository,
    );
  }

  configBloc.onUpdate(() async {
    await salatTimesCubit.updateSalatTimesInDbFromApi(
      config: configBloc.state,
      salatRepository: salatRepository,
    );

    await salatTimesCubit.fetchTodaySalatTimeFromDb(
      salatRepository: salatRepository,
    );
  });
}
