import 'package:flutter/services.dart';
import 'nyx_printer_platform_interface.dart';
import 'nyx_text_format.dart';

export 'nyx_text_format.dart';

class NyxPrinter {
  Future<int?> getVersion() {
    return NyxPrinterPlatform.instance.getVersion();
  }

  Future<int?> printText(String text, {NyxTextFormat? textFormat}) {
    return NyxPrinterPlatform.instance
        .printText(text, textFormat ?? NyxTextFormat());
  }

  Future<int?> printBarcode(String text, {int? width, int? height}) {
    return NyxPrinterPlatform.instance
        .printBarcode(text, width ?? 300, height ?? 160);
  }

  Future<int?> printQrCode(String text, {int? width, int? height}) {
    return NyxPrinterPlatform.instance
        .printQrCode(text, width ?? 300, height ?? 300);
  }

  Future<int?> printImage(Uint8List bytes) {
    return NyxPrinterPlatform.instance.printBitmap(bytes);
  }
}
