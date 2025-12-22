import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:sqlite3/sqlite3.dart';
import 'package:neda/lib.dart';

const dbFileExtension = '.db';

class DB {
  final String dbName;
  final Directory baseDirPath;
  late Database conn;
  late final File dbPath;

  DB(this.dbName, this.baseDirPath) {
    final dbDir = baseDirPath;
    if (!dbDir.existsSync()) {
      throw DbException.dbDirNotFoundException();
    }

    final fullDbPath = File(path.join(dbDir.path, dbName + dbFileExtension));
    dbPath = fullDbPath;

    open();
  }

  DB.open(this.dbPath)
    : dbName = dbPath.basename.substring(0, dbPath.basename.indexOf('.db')),
      baseDirPath = dbPath.dirname.asDirectory {
    open();
  }

  void close() {
    conn.close();
  }

  void open() {
    conn = sqlite3.open(dbPath.path);
  }
}

class DbException implements Exception {
  final String message;

  DbException(this.message);

  DbException.dbDirNotFoundException()
    : message =
          'DB dir not found – you have to pass a valid directory path to make the db file in';
}
