import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

abstract class Constraint implements SQLNamedObject {
  final String name;

  const Constraint([this.name]);

  String getName(SqlDialect dialect) {
    return dialect.getConstraintName(this);
  }
}
