import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('FutureExecutor (Somente processo)', () async {
    Function process = () {
      return true;
    };

    FutureExecutor executor = FutureExecutor(process: process);
    bool result = await executor.execute();
    expect(result, true);
  });

  test('FutureExecutor (Somente processo e then)', () async {
    Function process = () {
      return true;
    };

    Function(bool result) then = (result) {
      if(result) {
        return 1;
      } else {
        return 2;
      }
    };

    FutureExecutor executor = FutureExecutor(process: process, then: then);
    var result = await executor.execute();
    expect(result, 1);
  });

  test('FutureExecutor (Somente processo e erro)', () async {
    Function process = () {
      throw('Error test');
    };

    Function(Object error) error = (error) {
      return error;
    };

    FutureExecutor executor = FutureExecutor(process: process, error: error);
    var result = await executor.execute();
    expect((result is Error) || (result is Exception), true);
  });

  test('FutureExecutor (Processo, then e erro)', () async {
    Function process = () {
      return true;
    };

    Function(bool result) then = (result) {
      if(result) {
        return 1;
      } else {
        return 2;
      }
    };

    Function(Error error) error = (error) {
      print(error);
    };

    FutureExecutor executor = FutureExecutor(process: process, then: then, error: error);
    var result = await executor.execute();
    expect(result, 1);
  });
}