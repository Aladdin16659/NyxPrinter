import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nyx_printer/nyx_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nyxPrinterPlugin = NyxPrinter();

  @override
  void initState() {
    super.initState();
  }

  Future<void> printImage() async {
    try {
      final image = await rootBundle.load("images/img.png");
      await _nyxPrinterPlugin.printImage(image.buffer.asUint8List());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printText() async {
    try {
      await _nyxPrinterPlugin.printText("Welcome to Nyx");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printTextCenter() async {
    try {
      await _nyxPrinterPlugin.printText(
        "Welcome to Nyx",
        textFormat: NyxTextFormat(
          align: NyxAlign.center,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printTextRight() async {
    try {
      await _nyxPrinterPlugin.printText(
        "Welcome to Nyx",
        textFormat: NyxTextFormat(
          align: NyxAlign.right,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printBarcode() async {
    try {
      await _nyxPrinterPlugin.printBarcode(
        "123456789",
        width: 300,
        height: 40,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printQr() async {
    try {
      await _nyxPrinterPlugin.printQrCode(
        "123456789",
        width: 200,
        height: 200,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> printReceipt() async {
    try {
      await _nyxPrinterPlugin.printText(
        "Grocery Store",
        textFormat: NyxTextFormat(
          textSize: 32,
          align: NyxAlign.center,
          font: NyxFont.monospace,
          style: NyxFontStyle.boldItalic,
        ),
      );
      await _nyxPrinterPlugin.printText(
        "Invoice: 000001",
      );
      await _nyxPrinterPlugin.printText(
        "Seller: Mike",
      );
      await _nyxPrinterPlugin.printText("Neme\t\t\t\t\t\t\t\t\t\t\t\tPrice");
      await _nyxPrinterPlugin.printText(
        "Cucumber\t\t\t\t\t\t\t\t\t\t10\$",
        textFormat: NyxTextFormat(topPadding: 5),
      );
      await _nyxPrinterPlugin.printText("Potato Fresh\t\t\t\t\t\t\t\t\t15\$");
      await _nyxPrinterPlugin.printText("Tomato\t\t\t\t\t\t\t\t\t\t\t 9\$");
      await _nyxPrinterPlugin.printText(
        "Tax\t\t\t\t\t\t\t\t\t\t\t\t\t  4\$",
        textFormat: NyxTextFormat(
          topPadding: 5,
          style: NyxFontStyle.bold,
          textSize: 26,
        ),
      );
      await _nyxPrinterPlugin.printText(
        "Total\t\t\t\t\t\t\t\t\t\t\t\t34\$",
        textFormat: NyxTextFormat(
          topPadding: 5,
          style: NyxFontStyle.bold,
          textSize: 26,
        ),
      );
      await _nyxPrinterPlugin.printQrCode(
        "123456789",
        width: 200,
        height: 200,
      );
      await _nyxPrinterPlugin.printText("");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: printImage,
                    child: const Text('Print Image'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: printText,
                              child: const Text('Text Left'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: printTextCenter,
                              child: const Text('Text Center'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: printTextRight,
                              child: const Text('Text Right'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: printBarcode,
                      child: const Text('Print Barcode'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: printQr,
                      child: const Text('Print QR'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: printReceipt,
                      child: const Text('Print Receipt'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
