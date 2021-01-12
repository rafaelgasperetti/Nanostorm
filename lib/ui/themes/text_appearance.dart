import 'package:flutter/material.dart';
import 'package:nanostorm/ui/themes/ns_theme.dart';

enum COLOR {
  Primary, //Preto
  PrimaryLight, //Preto claro
  PrimaryDark, //Preto escuro
  Secondary, //Branco
  SecondaryLight, //Branco neve
  SecondaryDark, //Branco gelo
  Link, //Azul
  Highlight, //Vermelho
  Default //Padrão
}

enum FONT_WEIGHT { Soft, Normal, Bold, ExtraBold }

enum FONT_FAMILY { Text, Number }

class TextAppearance {
  TextStyle tiny(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeTiny,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  TextStyle small(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeSmall,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  TextStyle medium(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeMedium,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  TextStyle large(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeLarge,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  TextStyle veryLarge(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeVeryLarge,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  TextStyle extraLarge(
      {COLOR color = COLOR.Default,
      FONT_WEIGHT fontWeight = FONT_WEIGHT.Normal,
      FONT_FAMILY fontFamily = FONT_FAMILY.Text}) {
    return TextStyle(
        fontSize: NSTheme.fontSizeExtraLarge,
        color: getColor(color),
        fontWeight: getfontWeight(fontWeight),
        fontFamily: getFontFamily(fontFamily));
  }

  getColor(COLOR color) {
    switch (color) {
      case COLOR.Primary:
        return NSTheme.primaryColor;
        break;
      case COLOR.PrimaryLight:
        return NSTheme.primaryColorLight;
        break;
      case COLOR.PrimaryDark:
        return NSTheme.primaryColorDark;
        break;
      case COLOR.Secondary:
        return NSTheme.secondaryColor;
        break;
      case COLOR.SecondaryLight:
        return NSTheme.secondaryColorLight;
        break;
      case COLOR.SecondaryDark:
        return NSTheme.secondaryColorDark;
        break;
      case COLOR.Link:
        return NSTheme.linkColor;
        break;
      case COLOR.Highlight:
        return NSTheme.highlightColor;
        break;
      default:
        return NSTheme.defaultColor;
        break;
    }
  }

  getfontWeight(FONT_WEIGHT fontWeight) {
    switch (fontWeight) {
      case FONT_WEIGHT.Soft:
        return FontWeight.w400;
        break;
      case FONT_WEIGHT.Normal:
        return FontWeight.w500;
        break;
      case FONT_WEIGHT.Bold:
        return FontWeight.w700;
        break;
      case FONT_WEIGHT.ExtraBold:
        return FontWeight.w900;
        break;
      default:
        return FontWeight.w500;
        break;
    }
  }

  getFontFamily(FONT_FAMILY fontFamily) {
    switch (fontFamily) {
      case FONT_FAMILY.Text:
        return 'Raleway';
        break;
      case FONT_FAMILY.Number:
        return 'Lato';
        break;
      default:
        return 'Raleway';
        break;
    }
  }
}