import 'column.dart';

abstract class Cursor {
  List<Column> get columns;

  bool next();

  void close();
}
