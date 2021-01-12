import 'package:nsqlite/nsqlite.dart';
import 'package:meta/meta.dart';

class SQLiteDB extends BSDatabase {
  SQLiteDB(String name, int version,
      {@required List<Type> daos, List<Type> tables, List<Type> views})
      : super(name, version, daos: daos, views: views, tables: tables);

  @override
  SqlDialect get dialect => SQLiteDialect.getInstance();
}
