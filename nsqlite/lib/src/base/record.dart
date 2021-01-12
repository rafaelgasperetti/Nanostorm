import 'package:nsqlite/src/interfaces/cursor.dart';
import 'package:meta/meta.dart';

abstract class ReadWriteRecord extends Record {
  List<dynamic> insertFieldsParams();

  List<dynamic> updateFieldsParams();
}

abstract class ReadFromCursor<T> {
  @factory
  T readFromCursor(Cursor cursor);
}

abstract class Record {
  List<dynamic> primaryKeyFieldsParams();
}
