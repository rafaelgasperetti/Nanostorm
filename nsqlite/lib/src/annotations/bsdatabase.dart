import 'package:nsqlite/nsqlite.dart';
import 'package:nsqlite/src/base/extensions.dart';
import 'package:meta/meta.dart';

abstract class BSDatabase {
  final String name;
  final int version;
  final List<Type> daos;
  final List<Type> views;
  final List<Type> tables;

  SqlDialect get dialect;

  const BSDatabase(this.name, this.version,
      {@required this.daos, this.views, this.tables});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BSDatabase &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          version == other.version &&
          daos.equals(other.daos) &&
          views.equals(other.views) &&
          tables.equals(other.tables);

  @override
  int get hashCode =>
      name.hashCode ^
      version.hashCode ^
      daos.hashCode ^
      views.hashCode ^
      tables.hashCode;
}

class _TypeConverter {
  const _TypeConverter();
}

const typeConverter = _TypeConverter();
