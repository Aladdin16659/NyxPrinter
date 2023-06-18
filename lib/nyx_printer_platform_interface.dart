import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nyx_printer_method_channel.dart';
import 'nyx_text_format.dart';

abstract class NyxPrinterPlatform extends PlatformInterface {
  /// Constructs a NyxPrinterPlatform.
  NyxPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static NyxPrinterPlatform _instance = MethodChannelNyxPrinter();

  /// The default instance of [NyxPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelNyxPrinter].
  static NyxPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NyxPrinterPlatform] when
  /// they register themselves.
  static set instance(NyxPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<int?> getVersion() {
    return instance.getVersion();
  }

  Future<int?> printText(String text, NyxTextFormat textFormat) {
    return instance.printText(text, textFormat);
  }

  Future<int?> printBarcode(String text, int width, int height) {
    return instance.printBarcode(text, width, height);
  }

  Future<int?> printQrCode(String text, int width, int height) {
    return instance.printQrCode(text, width, height);
  }

  Future<int?> printBitmap(Uint8List bytes) {
    return instance.printBitmap(bytes);
  }
}
