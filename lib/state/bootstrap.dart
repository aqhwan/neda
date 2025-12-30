part of '../main.dart';

Future<void> bootstrap() async {
  ConfigCubit().stream.listen((cfg) async {
    print(cfg.oldCountry);
    await SalatTimesCubit().setSalatTimes(cfg);
  });
}
