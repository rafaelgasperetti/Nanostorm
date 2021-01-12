import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'constraints.dart';

class Default extends Constraint implements FieldConstraint {
  final String expression;

  const Default(this.expression, {String name}) : super(name);

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getDefault(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Default &&
          runtimeType == other.runtimeType &&
          expression == other.expression;

  @override
  int get hashCode => expression.hashCode;

  @override
  String toString() {
    return 'Default{expression: $expression, name: $name}';
  }
}
