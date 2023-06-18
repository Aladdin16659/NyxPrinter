import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nyx_printer/nyx_printer.dart';
import 'package:nyx_printer/nyx_printer_platform_interface.dart';
import 'package:nyx_printer/nyx_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNyxPrinterPlatform
    with MockPlatformInterfaceMixin
    implements NyxPrinterPlatform {
  @override
  Future<int?> getVersion() => Future.value(0);

  @override
  Future<int?> printBarcode(String text, int width, int height) =>
      Future.value(0);

  @override
  Future<int?> printBitmap(Uint8List bytes) => Future.value(0);

  @override
  Future<int?> printQrCode(String text, int width, int height) =>
      Future.value(0);

  @override
  Future<int?> printText(String text, NyxTextFormat textFormat) =>
      Future.value(0);
}

void main() {
  final NyxPrinterPlatform initialPlatform = NyxPrinterPlatform.instance;

  test('$MethodChannelNyxPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNyxPrinter>());
  });

  test('getPlatformVersion', () async {
    NyxPrinter nyxPrinterPlugin = NyxPrinter();
    MockNyxPrinterPlatform fakePlatform = MockNyxPrinterPlatform();
    NyxPrinterPlatform.instance = fakePlatform;

    expect(await nyxPrinterPlugin.getVersion(), 0);
  });
}
