import 'package:utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppUtils.initialize();

  test('Soma de Dinheiro', () {
    NSMoney dinheiro1 = NSMoney(n: 2.5);
    NSMoney dinheiro2 = NSMoney(n: 3);
    expect(dinheiro1 + dinheiro2, NSMoney(n: 5.5));
    expect(dinheiro1 - dinheiro2, NSMoney(n: -0.5));
  });

  test('Soma de Price', () {
    NSPrice price1 = NSPrice(n: 2.5);
    NSPrice price2 = NSPrice(n: 3);
    expect(price1 + price2, NSPrice(n: 5.5));
    expect(price1 - price2, NSPrice(n: -0.5));

    price1 += price2;
    expect(price1, NSPrice(n: 5.5));
  });

  test('Subtração de Dinheiro', () {
    NSMoney dinheiro1 = NSMoney(n: 2.5);
    NSMoney dinheiro2 = NSMoney(n: 3.0);
    expect(dinheiro1 - dinheiro2, NSMoney(n: -0.5));
  });

  test('Multiplicação de Dinheiro', () {
    NSMoney dinheiro1 = NSMoney(n: 3);
    NSMoney dinheiro2 = NSMoney(n: 3);
    expect(dinheiro1 * dinheiro2, NSMoney(n: 9));
  });

  test('Divisão de Dinheiro', () {
    NSMoney dinheiro1 = NSMoney(n: 9);
    NSMoney dinheiro2 = NSMoney(n: 3);
    expect(dinheiro1 / dinheiro2, NSMoney(n: 3));
  });

  test('Soma de DateTime', () {
    NSDateTime data = NSDateTime.fromString("30/10/2019");
    expect(data.toString(), "30/10/2019 00:00:00");
    data = data + NSTime(days: NSInt(n: 3));
    expect(data.toString(), "02/11/2019 00:00:00");
  });

  test('Subtração de DateTime', () {
    NSDateTime data = NSDateTime.fromString("30/10/2019");
    expect(data.toString(), "30/10/2019 00:00:00");
    data = data - NSTime(days: NSInt(n: 3));
    expect(data.toString(), "27/10/2019 00:00:00");
  });
}