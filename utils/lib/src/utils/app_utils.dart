import 'dart:core';
import 'dart:io';

import 'package:utils/utils.dart';
import 'package:flutter/foundation.dart';

class AppUtils {
  static Future<bool> isOnline({String address}) {
    if (StringUtils.isNullOrEmpty(address)) {
      address = NSConstants.VALIDACAO_REDE_1;
    }

    return InternetAddress.lookup(address)
        .then((result) => _processConnectionResult(result))
        .catchError((error) => _processConnectionError(address, error));
  }

  static Future<bool> _processConnectionError(String address, Object error) {
    if (error is SocketException) {
      if (address != NSConstants.VALIDACAO_REDE_2) {
        return isOnline(address: NSConstants.VALIDACAO_REDE_2);
      } else {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static bool _processConnectionResult(List<InternetAddress> result) {
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDebug() {
    if (kReleaseMode) {
      return false;
    } else {
      return true;
    }
  }

  static Future initialize() {
    return TypeUtils.initializeFormats();
  }

  static void printLog(String message) {
    print('${NSDateTime.now().toString()}: ${message ?? 'Não informado.'}');
  }
}
