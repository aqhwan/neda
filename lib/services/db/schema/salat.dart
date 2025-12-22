import 'package:neda/services/db/core/table.dart';

class SalatRepository extends Table {
  SalatRepository.of(super.db)
    : super.of(
        name: 'salat',
        columns: {
          'id': Column(
            name: 'id',
            type: 'INTEGER',
            primaryKey: true,
            autoIncrement: true,
          ),
          'date': Column(name: 'date', type: 'DATE', notNull: true),
          'fajr': Column(name: 'fajr', type: 'TIME'),
          'sunrise': Column(name: 'sunrise', type: 'TIME'),
          'dhuhr': Column(name: 'dhuhr', type: 'TIME'),
          'asr': Column(name: 'asr', type: 'TIME'),
          'maghrib': Column(name: 'maghrib', type: 'TIME'),
          'isha': Column(name: 'isha', type: 'TIME'),
        },
      );
}
