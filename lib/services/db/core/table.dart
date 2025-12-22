import 'package:neda/services/db/core/db.dart';

typedef LocalSemanticTableName = String;
typedef LocalSemanticColumnName = String;

typedef Schema = List<Table>;

class Column {
  final String name;
  final String type;
  final bool primaryKey;
  final bool unique;
  final bool notNull;
  final bool autoIncrement;
  final String? check;
  final String? referTo;
  final String? defaultValue;

  const Column({
    required this.name,
    required this.type,
    this.primaryKey = false,
    this.unique = false,
    this.notNull = false,
    this.autoIncrement = false,
    this.check,
    this.referTo,
    this.defaultValue,
  });

  String get sql {
    if (autoIncrement && (!primaryKey || type != 'INTEGER')) {
      throw TableException.usingAutoIncrementOnNonIntegerOrNotPrimaryKeyColumnException();
    }

    String sql = '$name $type';
    if (primaryKey) sql += ' PRIMARY KEY';
    if (unique) sql += ' UNIQUE';
    if (notNull) sql += ' NOT NULL';
    if (autoIncrement) sql += ' AUTOINCREMENT';
    if (check != null) sql += ' CHECK ($check)';
    if (referTo != null) sql += ' REFERENCES $referTo';
    if (defaultValue != null) sql += " DEFAULT '$defaultValue'";
    return sql;
  }
}

class Table {
  final String name;
  final Map<LocalSemanticColumnName, Column> columns;
  final Map<LocalSemanticTableName, Table>? helperTables;
  final DB db;

  Table.of(
    this.db, {
    required this.name,
    required this.columns,
    this.helperTables,
  }) {
    db.conn.execute(createTableSql);
  }

  String get createTableSql {
    List<String> primaryKeyColumn = [];

    final List<String> columnsSql = columns.values
        .map((column) {
          if (column.primaryKey) {
            primaryKeyColumn.add(column.name);
          }
          return column.sql;
        })
        .toList()
        .map((sqlColumn) {
          if (sqlColumn.contains('PRIMARY KEY')) {
            return sqlColumn
                .replaceAll(' PRIMARY KEY', '')
                .replaceAll(
                  'AUTOINCREMENT',
                  '',
                ); // becuase autoIncrement is only allowd in a column contain primaryKey attrbute on it in sql syntex
          } else {
            return sqlColumn;
          }
        })
        .toList();

    var primaryKeySqlDeclaration = 'PRIMARY KEY(${primaryKeyColumn.join(',')})';

    return 'CREATE TABLE IF NOT EXISTS $name (${columnsSql.join(',')}, $primaryKeySqlDeclaration)';
  }
}

class TableException implements Exception {
  final String message;

  TableException(this.message);

  TableException.usingAutoIncrementOnNonIntegerOrNotPrimaryKeyColumnException()
    : message =
          'using auto increment on non integer or not primary key column - AutoIncrement is only allowd in a column contain primaryKey attrbute on it in sql syntex';
}
