import 'package:flutter/material.dart';

class MaskedTextController extends TextEditingController {
  static String MASK_DDD = '(00)';
  static String MASK_TELEFONE_CELULAR = '(00)00000-0000';
  static String MASK_TELEFONE = '(00)0000-0000';
  static String MASK_TELEFONE_SEM_DDD = '0000-0000';
  static String MASK_CELULAR_SEM_DDD = '00000-0000';
  static String MASK_CNPJ = '00.000.000/0000-00';
  static String MASK_CPF = '000.000.000-00';
  static String MASK_CEP = '00.000-00';
  static String MASK_PLACA = '000-0000';

  List<String> mask;
  Map<String, RegExp> translator;
  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  MaskedTextController({String text, this.mask, Map<String, RegExp> translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    this.addListener(() {
      var previous = this._lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        this.updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        this.updateText(this._lastUpdatedText);
      }
    });

    this.updateText(this.text);
  }

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null && text.isNotEmpty) {
      this.text = this._applyMask(this.mask, text);
    } else {
      this.text = '';
    }

    this._lastUpdatedText = this.text;
  }

  void updateMask(List<String> mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    this.updateText(this.text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = this._lastUpdatedText;
    this.selection = new TextSelection.fromPosition(
        new TextPosition(offset: (text ?? '').length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return {
      'A': new RegExp(r'[A-Za-z]'),
      '0': new RegExp(r'[0-9]'),
      '@': new RegExp(r'[A-Za-z0-9]'),
      '*': new RegExp(r'.*')
    };
  }

  String _applyMask(List<String> masks, String value) {
    String result = '';

    var maskCharIndex = 0;
    var valueCharIndex = 0;
    String maskCurrent;

    for (String mask in masks) {
      if (value.length <= mask.length) {
        maskCurrent = mask;
        break;
      }
    }

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == maskCurrent.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      var maskChar = maskCurrent[maskCharIndex];
      var valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (this.translator.containsKey(maskChar)) {
        if (this.translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}

class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {double initialValue = 0.0,
      this.decimalSeparator = ',',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 2}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.parse(parts.join());
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
