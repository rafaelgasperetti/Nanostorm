import 'package:nsqlite/src/annotations/field.dart';
import 'package:nsqlite/src/annotations/table.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';

abstract class SQLNamedObject {
  String getName(SqlDialect dialect);
}

abstract class SQLItem {
  String getSQL(SqlDialect dialect);
}

abstract class SQLTableRelatedObject {
  String getCreateSQL(SqlDialect dialect, Table table,
      [bool whenNotExists = false]);

  String getDropSQL(SqlDialect dialect, Table table, [bool whenExists = false]);
}

abstract class SQLFieldRelatedObject {
  String getSQL(SqlDialect dialect, Field field);
}

abstract class SQLObject {
  String getCreateSQL(SqlDialect dialect, [bool whenNotExists = false]);

  String getDropSQL(SqlDialect dialect, [bool whenExists = false]);
}

abstract class FieldConstraint extends SQLItem {}

abstract class TableConstraint extends SQLItem {}
