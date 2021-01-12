import 'package:nsqlite/nsqlite.dart';
import 'package:nsqlite/src/annotations/table.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/sql.dart';

import 'collate.dart';

class Index implements SQLTableRelatedObject, SQLNamedObject {
  final String name;
  final List<IndexField> fields;
  final bool unique;
  final List<String> includes;
  final String where;

  const Index(this.name, this.fields,
      {this.unique = false, this.includes, this.where});

  @override
  String getCreateSQL(SqlDialect dialect, Table table,
      [bool whenNotExists = false]) {
    return dialect.getCreateIndex(this, table, whenNotExists);
  }

  @override
  String getDropSQL(SqlDialect dialect, Table table,
      [bool whenExists = false]) {
    return dialect.getDropIndex(this, table, whenExists);
  }

  @override
  String getName(SqlDialect dialect) {
    return dialect.getIndexName(this);
  }

  @override
  String toString() {
    return 'Index{name: $name, fields: $fields, unique: $unique, includes: $includes, where: $where}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Index &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          unique == other.unique &&
          where == other.where &&
          fields.equals(other.fields) &&
          includes.equals(other.includes);

  @override
  int get hashCode =>
      name.hashCode ^
      unique.hashCode ^
      includes.hashCode ^
      fields.hashCode ^
      where.hashCode;
}

List<IndexField> IndexFields(final List<String> fields) {
  return fields.map((field) => IndexField(field)).toList();
}

class IndexField implements SQLItem {
  final String name;
  final Collate collation;
  final bool descending;

  bool get ascending => !descending;

  const IndexField(this.name, {this.descending = false, this.collation});

  @override
  String getSQL(SqlDialect dialect) {
    return dialect.getIndexField(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndexField &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          collation == other.collation &&
          descending == other.descending;

  @override
  int get hashCode => name.hashCode ^ collation.hashCode ^ descending.hashCode;

  @override
  String toString() {
    return 'IndexField{name: $name, collation: $collation, descending: $descending}';
  }
}
