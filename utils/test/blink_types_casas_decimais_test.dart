import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('Casas Decimais NSMoney', () {
    NSMoney testeDigitacao = NSDecimal.fromString("1543,43", type: NSMoney);
    expect(testeDigitacao.toString(), "R\$ 1.543,4300");
    NSMoney testeDigitacao2 = NSDecimal.fromString("R\$1543,43", type: NSMoney);
    expect(testeDigitacao2.toString(), "R\$ 1.543,4300");
  });
}