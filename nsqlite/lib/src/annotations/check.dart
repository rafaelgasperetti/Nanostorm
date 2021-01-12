import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'constraints.dart';

class Check extends Constraint implements FieldConstraint, TableConstraint {
  final String expression;

  const Check(this.expression, {String name})
      : assert(expression != null && expression != ''),
        super(name);

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getCheck(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Check &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          expression == other.expression;

  @override
  int get hashCode => expression.hashCode;

  @override
  String toString() {
    return 'Check{expression: $expression, name: $name}';
  }
}
