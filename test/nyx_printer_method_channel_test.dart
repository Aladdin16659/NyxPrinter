import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nyx_printer/nyx_printer_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNyxPrinter platform = MethodChannelNyxPrinter();
  const MethodChannel channel = MethodChannel('nyx_printer');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 0;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getVersion(), 0);
  });
}
