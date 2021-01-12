import 'package:nsqlite/src/annotations/fields.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'index.dart';

class View implements SQLNamedObject, SQLObject {
  final String name;
  final String schema;
  final String body;
  final List<TableConstraint> constraints;
  final List<Index> indexes;
  final Fields fields;

  const View(
      {this.name, this.schema, this.body, this.indexes, this.constraints})
      : fields = null;

  const View.withFields(
      {this.name,
      this.schema,
      this.body,
      this.indexes,
      this.constraints,
      this.fields});

  @override
  String getCreateSQL(SqlDialect dialect, [bool whenNotExists = false]) {
    return dialect.getCreateView(this, whenNotExists);
  }

  @override
  String toString() {
    return 'View{name: $name, schema: $schema, body: $body, constraints: $constraints, indexes: $indexes, fields: $fields}';
  }

  @override
  String getDropSQL(SqlDialect dialect, [bool whenExists = false]) {
    return dialect.getDropView(this, whenExists);
  }

  @override
  String getName(SqlDialect dialect) {
    return dialect.getViewName(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is View &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          fields == other.fields &&
          schema == other.schema &&
          indexes.equals(other.indexes) &&
          constraints.equals(other.constraints);

  @override
  int get hashCode =>
      name.hashCode ^
      schema.hashCode ^
      fields.hashCode ^
      constraints.hashCode ^
      indexes.hashCode;
}
