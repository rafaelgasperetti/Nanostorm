import 'package:nsqlite/src/interfaces/parameters.dart';

import 'statement.dart';

abstract class Column<T> extends ColumnValue<T> {
  final int index;

  Column(this.statement, this.index);

  Statement statement;

  String get name;

  int get type;

  bool get isNull;

  T get valueOrNull => isNull ? null : value;

  Type _typeOf<T>() => T;

  Type get dartType => _typeOf<Column<T>>();

  void bindTo(Parameters parameters, int index);

  void bindValueTo(Parameters parameters, int index) {
    if (isNull)
      parameters.bindNull(index);
    else
      bindTo(parameters, index);
  }
}

abstract class ColumnValue<T> {
  T get value;
}

abstract class ColumnCreator<T> {
  Column<T> getColumn(Statement statement, int index);
}
