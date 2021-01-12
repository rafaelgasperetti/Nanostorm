import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('Cast NSMoney (< 1000)', () {
    NSMoney teste = NSMoney(n: 3.42333);
    String str = teste.toString();
    NSMoney teste2 = NSDecimal.fromString(str, type: NSMoney);
    expect(teste2.toString(), "R\$ 3,4233");
    NSDecimal teste3 = NSDecimal.fromString(teste2.value.toString());
    expect(teste3.toString(), "3,423300");
  });

  test('Cast NSMoney (>= 1000 && < 1000000)', () {
    NSMoney testeMil = NSMoney(n: 3487.54681);
    expect(testeMil.toString(), "R\$ 3.487,5468");
    NSMoney testeMilRet = NSDecimal.fromString(testeMil.toString(), type: NSMoney);
    expect(testeMilRet.toString(), "R\$ 3.487,5468");
  });

  test('Cast NSMoney (>= 1000000)', () {
    NSMoney testeMilhao = NSMoney(n: 12433487.54681);
    expect(testeMilhao.toString(), "R\$ 12.433.487,5468");
    NSMoney testeMilhaoRet = NSDecimal.fromString(testeMilhao.toString(), type: NSMoney);
    expect(testeMilhaoRet.toString(), "R\$ 12.433.487,5468");
  });

  test('Cast NSWeight', () {
    NSWeight weight = NSWeight(n: 3.214);
    expect(weight.toString(), "3,21 Kg");
    NSWeight weight2 = NSDecimal.fromString(weight.toString(), type: NSWeight);
    expect(weight2.toString(), "3,21 Kg");
  });


  test('Cast NSPercent', () {
    NSPercent percent = NSPercent(n: 3.214);
    expect(percent.toString(), "3,21 %");
    NSPercent percent2 = NSDecimal.fromString(percent.toString(), type: NSPercent);
    expect(percent2.toString(), "3,21 %");
  });

  test('Cast NSDateTime', () {
    NSDateTime data = NSDateTime.fromString("30/10/2019");
    expect(data.toString(), "30/10/2019 00:00:00");
    NSDate data2 = NSDate.fromString("30/10/2019");
    expect(data2.toString(), "30/10/2019");
  });

  test('Cast NSGuid', () {
    NSGuid nSGuid = NSGuid.fromString("30A4CB9A-9BA6-443F-87D9-172C0471BEE2");
    expect(nSGuid.toString(), "30A4CB9A-9BA6-443F-87D9-172C0471BEE2".toLowerCase());
    NSGuid random = NSGuid.randomNSGuid();
    bool gerado = random != null;
    expect(gerado, true);
    NSGuid empty = NSGuid.empty();
    expect(empty.toString(), "00000000-0000-0000-0000-000000000000");
  });
}