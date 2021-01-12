import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanostorm/ui/themes/style_default.dart';

enum ThemeOptions { DEFAULT }

class NSTheme {
  static final themeOptions = ThemeOptions.DEFAULT;
  static double scaleFactor;

  static double fontSizeTiny;
  static double fontSizeSmall;
  static double fontSizeMedium;
  static double fontSizeLarge;
  static double fontSizeVeryLarge;
  static double fontSizeExtraLarge;

  static final Color primaryColor = StyleDefault.black;
  static final Color primaryColorLight = StyleDefault.black;
  static final Color primaryColorDark = StyleDefault.black;
  static final Color secondaryColor = StyleDefault.whiteIce;
  static final Color secondaryColorLight = StyleDefault.white;
  static final Color secondaryColorDark = StyleDefault.whiteIce;
  static final Color linkColor = StyleDefault.blue;
  static final Color highlightColor = StyleDefault.lightRed;
  static final Color defaultColor = StyleDefault.black;
  static final Color dimmedColor = StyleDefault.grey;

  static final Color favoriteOn = StyleDefault.red;
  static final Color favoriteOff = StyleDefault.grey;

  NSTheme() {
    var dpr = window.devicePixelRatio;

    scaleFactor = 1;
    if (dpr < 3.5) scaleFactor = 0.9;
    if (dpr < 2.5) scaleFactor = 0.85;
    if (dpr < 2.0) scaleFactor = 0.8;

    fontSizeTiny = 10.0;
    fontSizeSmall = 12.0 * scaleFactor;
    fontSizeMedium = 14.0 * scaleFactor;
    fontSizeLarge = 16.0 * scaleFactor;
    fontSizeVeryLarge = 18.0 * scaleFactor;
    fontSizeExtraLarge = 26.0 * scaleFactor;
  }

  get theme => ThemeData(
      primarySwatch: getPrimarySwatch,
      backgroundColor: StyleDefault.whiteIce,
      accentColor: Colors.blue,
      brightness: Brightness.light,
      canvasColor: Colors.transparent,
      fontFamily: 'Raleway',
      
      );

  static String getSufixoLogin() {
    return 'Nanostorm';
  }

  static String getImageLogin() {
    return 'assets/images/bateforte/logo_login.png';
  }
  static String getImageDrawerMenu() {
    return 'assets/images/bateforte/logo_drawer.png';
  } 
  static String getImageAppBar() {
    return 'assets/images/bateforte/logo_appbar.png';
  }

  static String getImageSplash() {
    return 'assets/images/bateforte/splash.png';
  }

  static String getImagePerfilSemFoto() {
    return 'assets/images/ic_perfil_sem_foto.png';
  }

  static String getImageMinhaCarteira() {
    return 'assets/images/ic_carteira.png';
  }

  static String getImageEditar() {
    return 'assets/images/ic_editar.png';
  }

  static Color getAppBarColor(){
    return StyleDefault.lightBlue;
  }

  static Color getBGColorCardMensagemItem() {
    return StyleDefault.lightGrey;
  }

  static Color getBGColorMenu() {
    return StyleDefault.blue;
  }

  static Color getBGColor() {
    return StyleDefault.lightGrey;
  }

  static Color getBGColorMenuCarteira() {
    return StyleDefault.darkBlue;
  }

  static Color getBGColorBadge() {
    return StyleDefault.darkBlue;
  }

  static Color getBGColorMenuItens() {
    return StyleDefault.lightBlue;
  }

  static Color getBGColorCardText() {
    return StyleDefault.whiteIce;
  }

  static Color getBGColorCard() {
    return StyleDefault.whiteIce;
  }

  static Color getBGColorCardCadastro() {
    return StyleDefault.green;
  }

  static Color getFavoriteOn() {
    return favoriteOn;
  }

  static Color getFavoriteOff() {
    return favoriteOff;
  } 

  static double getPaddingMultiplier(double multiplier) {
    return 6.0 * (multiplier ?? 1);
  }

  static double getNSTextFieldPadding() {
    return 4;
  }

  static double getBorderRadiusMultiplier(double multiplier) {
    return 36.0 * (multiplier == null || multiplier < 1 ? 1 : multiplier);
  }

  static double getScreenWidthPercent(BuildContext context, int percent) {
    percent = percent < 0 || percent > 100 ? 100 : percent;
    return MediaQuery.of(context).size.width * (percent / 100);
  }

  static double getScreenHeightPercent(BuildContext context, int percent) {
    percent = percent < 0 || percent > 100 ? 100 : percent;
    return MediaQuery.of(context).size.height * (percent / 100);
  }

  static double getMaxModalWidth(BuildContext context) {
    return getScreenWidthPercent(context, 92);
  }
  
  static double getModalOpacity() {
    return 0.3;
  }
}

const MaterialColor getPrimarySwatch = const MaterialColor(
    0xFFD13B3B,
    const <int, Color>{
      50: const Color(0xFF000FFF),
      100: const Color(0xFF000FFF),
      200: const Color(0xFF000FFF),
      300: const Color(0xFF000FFF),
      400: const Color(0xFF000FFF),
      500: const Color(0xFF000FFF),
      600: const Color(0xFF000FFF),
      700: const Color(0xFF000FFF),
      800: const Color(0xFF000FFF),
      900: const Color(0xFF000FFF)
    });

