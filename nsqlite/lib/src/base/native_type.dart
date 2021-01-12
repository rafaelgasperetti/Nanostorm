import 'package:nsqlite/src/annotations/field.dart';

import 'sql_dialect.dart';
import 'types.dart';

abstract class NativeType<T> extends DataType<T> {
  Type _typeOf<TYPE>() => TYPE;

  Type get type => _typeOf<T>();

  NativeType(String name,
      {bool hasSize = false,
      bool hasDecimals = false,
      bool defaultForType = false})
      : super(name,
            hasSize: hasSize,
            hasDecimals: hasDecimals,
            defaultForType: defaultForType);

  @override
  String getSQL(SqlDialect dialect, Field field) {
    return dialect.getType(this, field);
  }
}
