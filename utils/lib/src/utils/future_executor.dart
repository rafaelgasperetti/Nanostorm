import 'dart:async';

import 'package:flutter/cupertino.dart';

class FutureExecutor {
  Function _process;
  Function _then;
  Function _error;

  FutureExecutor({@required process, then, error}) : assert(process != null) {
    _process = process;
    _then = then;
    _error = error;
  }

  Future execute() {
    Future result;

    if(this._then == null) {
      result = Future(() => _runFunction(this._process, null));
    }
    else {
      result = Future(() => _runFunction(this._process, null))
          .then((result) => _runFunction(this._then, result));
    }

    return result;
  }

  _runFunction(Function f, param) {
    try {
      if(param != null) {
        return f(param);
      }
      else {
        return f();
      }
    }
    catch(e) {
      if(_error != null) {
        if(e is Error || e is Exception) {
          return _error(e);
        }
        else if(e is String) {
          return _error(Exception(e));
        }
        else {
          return e;
        }
      }
      else {
        return e;
      }
    }
  }
}