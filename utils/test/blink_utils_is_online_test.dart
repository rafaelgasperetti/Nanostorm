import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('IsOnline Test', () async {
    bool online = await AppUtils.isOnline();

    //Resultado apenas para verificar se há algum retorno
    if(online) {
      assert(online, true);
    }
    else {
      assert(online, false);
    }
  });
}