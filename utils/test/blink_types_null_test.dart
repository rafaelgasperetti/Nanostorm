import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('Máscara', () {
    String NSDecimalMask = NSDecimal.getString(null, type: NSMoney);
    expect(NSDecimalMask, "R\$ 0,0000");
  });
}