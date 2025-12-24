import 'package:neda/lib.dart';
import 'package:neda/modele/salat.dart';
import 'package:neda/services/db/core/table.dart';
import 'package:time/time.dart';

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

  Future<void> overwriteAll(List<Salat> salat) async {
    final currentDataIds = db.conn
        .select('SELECT id FROM salat')
        .map<int>((e) => e['id'])
        .toList();

    final sql = db.conn.prepare('''
      INSERT INTO $name (
        ${columns['date']!.name},
        ${columns['fajr']!.name},
        ${columns['sunrise']!.name},
        ${columns['dhuhr']!.name},
        ${columns['asr']!.name},
        ${columns['maghrib']!.name},
        ${columns['isha']!.name}
      ) VALUES (?, ?, ?, ?, ?, ?, ?)''');

    for (final salatTime in salat) {
      sql.execute([
        salatTime.date.asStringSeparatedByDash(),
        salatTime.fajr.asString(),
        salatTime.sunrise.asString(),
        salatTime.dhuhr.asString(),
        salatTime.asr.asString(),
        salatTime.maghrib.asString(),
        salatTime.isha.asString(),
      ]);
    }

    db.conn.execute(
      'DELETE FROM $name WHERE id NOT IN (${currentDataIds.join(',')})',
    );
  }

  Future<Salat>? getTodayPrayerTimes() async {
    final todayPrayerTimes = db.conn
        .select('SELECT * FROM $name WHERE date = ?', [
          DateTime.now().asStringSeparatedByDash(),
        ])
        .map((e) => SalatJson.fromJson(e))
        .first;

    return todayPrayerTimes;
  }
}
