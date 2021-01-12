import 'dart:ffi';
import 'dart:typed_data';

import 'package:nsqlite/src/ffi/blob.dart';
import 'package:nsqlite/src/ffi/types.dart' as types;
import 'package:nsqlite/src/ffi/utils.dart';
import 'package:nsqlite/nsqlite.dart';

import '../native/bindings.dart';
import 'sqlite_errors.dart';

class SQLiteParameters implements Parameters<Pointer<types.Statement>> {
  final List<Pointer> _allocatedWhileBinding = [];
  bool _bound = false;

  Pointer<types.Statement> statement;

  SQLiteParameters(this.statement);

  @override
  String name(int paramIndex) {
    return bindings
        .sqlite3_bind_parameter_name(statement, paramIndex)
        .readString();
  }

  @override
  int index(String name) {
    String key = name;
    if (!key.startsWith('@')) {
      key = '@' + name;
    }
    final ptr = CBlob.allocateString(key);
    _allocatedWhileBinding.add(ptr);
    return bindings.sqlite3_bind_parameter_index(statement, ptr);
  }

  @override
  void bindNamed(Map<String, dynamic> params) {
    release();
    if (params != null && params.isNotEmpty) {
      for (var param in params.entries) {
        int paramIndex = index(param.key);

        if (paramIndex > 0)
          bindDynamic(paramIndex, param.value);
        else
          throw SQLiteException('Parameter name ${param.key} not found');
      }
    }
    _bound = true;
  }

  @override
  void bind(List<dynamic> params) {
    release();
    if (params != null && params.isNotEmpty) {
      // variables in sqlite are 1-indexed
      for (var i = 1; i <= params.length; i++) {
        final param = params[i - 1];
        bindDynamic(i, param);
      }
    }
    _bound = true;
  }

  @override
  void release() {
    if (_bound) {
      bindings.sqlite3_reset(statement);
      _bound = false;
    }

    if (_allocatedWhileBinding.isNotEmpty) {
      for (var pointer in _allocatedWhileBinding) {
        pointer.free();
      }
      _allocatedWhileBinding.clear();
    }
  }

  @override
  void bindBlob(int index, Uint8List value) {
    if (value.isEmpty) {
      bindings.sqlite3_bind_zeroblob(statement, index, 0);
    } else {
      final ptr = CBlob.allocate(value);
      _allocatedWhileBinding.add(ptr);
      bindings.sqlite3_bind_blob(statement, index, ptr, value.length, nullptr);
    }
  }

  @override
  void bindDouble(int index, double value) {
    bindings.sqlite3_bind_double(statement, index, value);
  }

  @override
  void bindInt(int index, int value) {
    if (value.bitLength > 32) {
      bindInt64(index, value);
    } else {
      bindInt32(index, value);
    }
  }

  @override
  void bindInt32(int index, int value) {
    bindings.sqlite3_bind_int(statement, index, value);
  }

  @override
  void bindInt64(int index, int value) {
    bindings.sqlite3_bind_int64(statement, index, value);
  }

  @override
  void bindNull(int index) {
    bindings.sqlite3_bind_null(statement, index);
  }

  @override
  void bindString(int index, String value) {
    final ptr = CBlob.allocateString(value);
    _allocatedWhileBinding.add(ptr);
    bindings.sqlite3_bind_text(statement, index, ptr, -1, nullptr);
  }

  @override
  void bindDynamic(int index, value) {
    if (value == null) {
      bindNull(index);
    } else {
      if (value is String) {
        bindString(index, value);
      } else if (value is int) {
        bindInt(index, value);
      } else if (value is num) {
        bindDouble(index, value);
      } else if (value is Uint8List) {
        bindBlob(index, value);
      }
    }
  }
}
