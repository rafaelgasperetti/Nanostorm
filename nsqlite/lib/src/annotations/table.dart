import 'package:nsqlite/src/annotations/fields.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'check.dart';
import 'foreign_key.dart';
import 'index.dart';
import 'primary_key.dart' as primaryKeyDef;
import 'trigger.dart';
import 'unique.dart' as uniqueDef;

class Table {
  final String name;
  final String schema;
  final List<TableConstraint> constraints;
  final List<Trigger> triggers;
  final List<Index> indexes;
  final Fields fields;

  const Table(
      {this.name,
      this.schema,
      this.triggers,
      this.indexes,
      this.constraints = const []})
      : fields = null;

  Table.withFields(
      {this.name,
      this.schema,
      this.triggers,
      this.indexes,
      List<TableConstraint> constraints,
      this.fields})
      : this.constraints = constraints ?? List<TableConstraint>() {
    primaryKeyDef.PrimaryKey primaryKeyConstraint =
        this.constraints.whereType<primaryKeyDef.PrimaryKey>().firstOrNull;
    if (primaryKeyConstraint == null && fields.primaryKey.isNotEmpty) {
      this.constraints.add(primaryKeyDef.PrimaryKey(
          fields.primaryKey.map((f) => IndexField(f.name)).toList()));
    }
  }

  primaryKeyDef.PrimaryKey get primaryKey =>
      constraints.whereType<primaryKeyDef.PrimaryKey>()?.first;

  List<uniqueDef.Unique> get uniques =>
      List.unmodifiable(constraints.whereType<uniqueDef.Unique>());

  List<Check> get checks => List.unmodifiable(constraints.whereType<Check>());

  List<ForeignKey> get foreignKeys =>
      List.unmodifiable(constraints.whereType<ForeignKey>());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Table &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          schema == other.schema &&
          fields == other.fields &&
          constraints.equals(other.constraints) &&
          triggers.equals(other.triggers) &&
          indexes.equals(other.indexes);

  @override
  String toString() {
    return 'Table{name: $name, schema: $schema, constraints: $constraints, triggers: $triggers, indexes: $indexes, fields: $fields}';
  }

  @override
  int get hashCode =>
      name.hashCode ^
      schema.hashCode ^
      fields.hashCode ^
      constraints.hashCode ^
      triggers.hashCode ^
      indexes.hashCode;
}
