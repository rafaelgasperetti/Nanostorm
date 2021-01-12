import 'package:nsqlite/src/sqlite/types/sqlite_converters.dart';
import 'package:nsqlite/nsqlite.dart';

import 'sqlite_native_types.dart';

class SQLiteTypes {
  SQLiteTypes() {
    final NativeType int32Type = SQLiteInt32();
    final NativeType int64Type = SQLiteInt64();
    final NativeType intType = SQLiteInt();
    final NativeType textType = SQLiteText();
    final NativeType blobType = SQLiteBlob();
    final NativeType doubleType = SQLiteDouble();

    final CustomType<bool, int> boolType =
        CustomType(int32Type, SQLiteConverters.boolConverter);
    final CustomType<DateTime, int> intDateType =
        CustomType(int64Type, SQLiteConverters.intDateTimeConverter);
    final CustomType<DateTime, String> stringDateType =
        CustomType(textType, SQLiteConverters.stringDateTimeConverter);
    _allTypes = [
      int32Type,
      int64Type,
      intType,
      textType,
      blobType,
      doubleType,
      boolType,
      intDateType,
      stringDateType
    ];
  }

  List<DataType> _allTypes;

  List<DataType> get allTypes => _allTypes;
}
