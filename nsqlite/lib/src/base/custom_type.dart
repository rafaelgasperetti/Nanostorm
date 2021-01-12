import 'package:nsqlite/src/annotations/field.dart';
import 'package:nsqlite/src/base/sql_dialect.dart';
import 'package:nsqlite/src/interfaces/column.dart';
import 'package:nsqlite/src/interfaces/parameters.dart';
import 'package:nsqlite/src/interfaces/statement.dart';

import 'native_type.dart';
import 'types.dart';

abstract class TypeConverter<DART, DB> {
  const TypeConverter();

  DART getValue(DB value);

  DB getDBValue(DART value);
}

class CustomType<DART, DB> extends DataType<DART> {
  Type _typeOf<TYPE>() => TYPE;

  Type get type => _typeOf<DART>();

  final NativeType<DB> nativeType;
  TypeConverter<DART, DB> typeConverter;

  CustomType(this.nativeType, this.typeConverter, {bool defaultForType})
      : super(nativeType.name,
            hasSize: nativeType.hasSize,
            hasDecimals: nativeType.hasDecimals,
            defaultForType: defaultForType);

  @override
  Column<DART> getColumn(Statement statement, int index) {
    return CustomTypeColumn<DART, DB>(
        nativeType.getColumn(statement, index), typeConverter);
  }

  @override
  String getSQL(SqlDialect dialect, Field field) {
    return nativeType.getSQL(dialect, field);
  }
}

class CustomTypeColumn<DART, DB> extends Column<DART> {
  Column<DB> nativeColumn;
  TypeConverter<DART, DB> typeConverter;

  CustomTypeColumn(this.nativeColumn, this.typeConverter)
      : super(nativeColumn.statement, nativeColumn.index);

  @override
  DART get value => typeConverter.getValue(nativeColumn.value);

  @override
  Statement get statement => nativeColumn.statement;

  @override
  void bindTo(Parameters parameters, int index) {
    nativeColumn.bindTo(parameters, index);
  }

  @override
  bool get isNull => nativeColumn.isNull;

  @override
  String get name => nativeColumn.name;

  @override
  int get type => nativeColumn.type;

  @override
  DART get valueOrNull => isNull ? null : value;
}
