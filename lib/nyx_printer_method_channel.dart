import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'nyx_printer_platform_interface.dart';
import 'nyx_text_format.dart';

/// An implementation of [NyxPrinterPlatform] that uses method channels.
class MethodChannelNyxPrinter extends NyxPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nyx_printer');

  @override
  Future<int?> getVersion() async {
    final version = await methodChannel.invokeMethod<int?>('getVersion');
    return version;
  }

  @override
  Future<int?> printText(String text, NyxTextFormat textFormat) async {
    Map<String, dynamic> data = {"text": text};
    data.addAll(textFormat.toMap());
    final version = await methodChannel.invokeMethod<int?>('printText', data);
    return version;
  }

  @override
  Future<int?> printBarcode(String text, int width, int height) async {
    final version = await methodChannel.invokeMethod<int?>('printBarcode', {
      "text": text,
      "width": width,
      "height": height,
    });
    return version;
  }

  @override
  Future<int?> printQrCode(String text, int width, int height) async {
    final version = await methodChannel.invokeMethod<int?>('printQrCode', {
      "text": text,
      "width": width,
      "height": height,
    });
    return version;
  }

  @override
  Future<int?> printBitmap(Uint8List bytes) async {
    final version =
        await methodChannel.invokeMethod<int?>('printBitmap', {"bytes": bytes});
    return version;
  }
}
