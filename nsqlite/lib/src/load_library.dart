import 'dart:ffi';
import 'dart:io';

/// Signature responsible for loading the dynamic sqlite3 library that bssqlite will
/// use.
typedef OpenLibrary = DynamicLibrary Function();

enum OperatingSystem {
  android,
  linux,
  iOS,
  macOS,
  windows,
  fuchsia,
}

/// The instance managing different approaches to load the [DynamicLibrary] for
/// sqlite when needed. See the documentation for [OpenDynamicLibrary] to learn
/// how the default opening behavior can be overridden.
final OpenDynamicLibrary open = OpenDynamicLibrary._();

DynamicLibrary _defaultOpen() {
  if (Platform.isLinux || Platform.isAndroid) {
    return DynamicLibrary.open('libsqlite3x.so');
  }
  if (Platform.isMacOS || Platform.isIOS) {
    // todo when we use a dev version of Dart 2.6, we can (and should!!) use DynamicLibrary.executable() here
//     return DynamicLibrary.executable();
    return DynamicLibrary.open('/usr/lib/libsqlite3.dylib');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('sqlite3.dll');
  }

  throw UnsupportedError(
      'bssqlite does not support ${Platform.operatingSystem} yet');
}

/// Manages functions that define how to load the [DynamicLibrary] for sqlite.
///
/// The default behavior will use `DynamicLibrary.open('libsqlite3.so')` on
/// Linux and Android, `DynamicLibrary.open('libsqlite3.dylib')` on iOS and
/// macOS and `DynamicLibrary.open('sqlite3.dll')` on Windows.
///
/// The default behavior can be overridden for a specific OS by using
/// [overrideFor]. To override the behavior on all platforms, use
/// [overrideForAll].
class OpenDynamicLibrary {
  final Map<OperatingSystem, OpenLibrary> _overriddenPlatforms = {};
  OpenLibrary _overriddenForAll;

  OpenDynamicLibrary._();

  /// Returns the current [OperatingSystem] as read from the [Platform] getters.
  OperatingSystem get os {
    if (Platform.isAndroid) return OperatingSystem.android;
    if (Platform.isLinux) return OperatingSystem.linux;
    if (Platform.isIOS) return OperatingSystem.iOS;
    if (Platform.isMacOS) return OperatingSystem.macOS;
    if (Platform.isWindows) return OperatingSystem.windows;
    if (Platform.isFuchsia) return OperatingSystem.fuchsia;
    return null;
  }

  /// Opens the [DynamicLibrary] from which `bssqlite` is going to
  /// [DynamicLibrary.lookup] sqlite's methods that will be used. This method is
  /// meant to be called by `bssqlite` only.
  DynamicLibrary openSqlite() {
    if (_overriddenForAll != null) {
      return _overriddenForAll();
    }

    final forPlatform = _overriddenPlatforms[os];
    if (forPlatform != null) {
      return forPlatform();
    }

    return _defaultOpen();
  }

  /// Makes `bssqlite` use the [open] function when running on the specified
  /// [os]. This can be used to override the loading behavior on some platforms.
  /// To override that behavior on all platforms, consider using
  /// [overrideForAll].
  /// This method must be called before opening any database.
  ///
  /// When using the asynchronous API over isolates, [open] __must be__ a top-
  /// level function or a static method.
  void overrideFor(OperatingSystem os, OpenLibrary open) {}

  /// Makes `bssqlite` use the [OpenLibrary] function for all Dart platforms.
  /// If this method has been called, it takes precedence over [overrideFor].
  /// This method must be called before opening any database.
  ///
  /// When using the asynchronous API over isolates, [open] __must be__ a top-
  /// level function or a static method.
  void overrideForAll(OpenLibrary open) {}
}
