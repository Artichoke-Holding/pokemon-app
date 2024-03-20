import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'dart:io' show Platform; // Import Platform

class PlatformUtils {
  static bool isWeb() {
    return kIsWeb;
  }

  static bool isIOS() {
    if (isWeb()) return false;
    return Platform.isIOS;
  }

  static bool isAndroid() {
    if (isWeb()) return false;
    return Platform.isAndroid;
  }

}
