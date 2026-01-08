import 'package:flutter/material.dart';
import 'package:neda/lib.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blocs/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final blocs = await bootstrap();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ConfigBloc>(create: (context) => ConfigBloc()),
        BlocProvider<SalatTimesCubit>.value(
          // Use .value with existing instance
          value: blocs['salatTimesCubit']!,
        ),
      ],
      child: NedaApp(),
    ),
  );
}
