import 'dart:collection';

import 'package:nsqlite/src/annotations/field.dart';
import 'package:nsqlite/src/base/extensions.dart';

class Fields extends ListBase<Field> {
  List<Field> _fields;

  int get length => _fields.length;

  void set length(int length) {
    _fields.length = length;
  }

  void operator []=(int index, Field value) {
    _fields[index] = value;
  }

  Field operator [](int index) => _fields[index];

  void add(Field value) => _fields.add(value);

  void addAll(Iterable<Field> all) => _fields.addAll(all);

  List<Field> get primaryKey =>
      List.unmodifiable(_fields.where((field) => field.primaryKey));

  List<Field> get unique =>
      List.unmodifiable(_fields.where((field) => field.unique));

  List<Field> get nonPrimaryKey =>
      List.unmodifiable(_fields.where((field) => !field.primaryKey));

  List<Field> get forInsert => List.unmodifiable(
      _fields.where((field) => !field.autoIncrement).toList());

  List<Field> get forUpdate => List.unmodifiable(_fields
      .where((field) => !field.primaryKey && !field.autoIncrement)
      .toList());

  Field get autoIncrement => _fields.firstWhere((field) => field.autoIncrement);

  Fields([this._fields]) {
    this._fields ??= List<Field>();
  }

  @override
  bool operator ==(other) => equals(other);
}
