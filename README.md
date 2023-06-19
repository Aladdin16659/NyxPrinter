
# Nyx Printer 

Flutter Plugin that connect to Nyx devices Printer such as NB55.


## Installation

Install Nyx Printer with pub

```bash
  flutter pub add nyx_printer
```
    
![Receipt](https://raw.githubusercontent.com/Aladdin16659/NyxPrinter/main/example/images/receipt.jpeg)


## Print Image

```dart
import 'package:nyx_printer/nyx_printer.dart';
  ...
  final _nyxPrinterPlugin = NyxPrinter();

  Future<void> printImage() async {
    final image = await rootBundle.load("images/img.png");
    await _nyxPrinterPlugin.printImage(image.buffer.asUint8List());
  }
```
## Print Text

```dart
  Future<void> printText() async {
      await _nyxPrinterPlugin.printText(
        "Grocery Store",
        textFormat: NyxTextFormat(
          textSize: 32,
          align: NyxAlign.center,
          font: NyxFont.monospace,
          style: NyxFontStyle.boldItalic,
        ),
      );
  }
```
## Print QR

```dart
  Future<void> printQrCode() async {
      await _nyxPrinterPlugin.printQrCode(
        "123456789",
        width: 200,
        height: 200,
      );
  }
```
## Print Barcode

```dart
  Future<void> printBarcode() async {
      await _nyxPrinterPlugin.printBarcode(
        "123456789",
        width: 300,
        height: 40,
      );
  }
```


## License

[MIT](https://github.com/Aladdin16659/NyxPrinter/blob/main/LICENSE)
Copyright (c) 2023 ALADDIN SID AHMED

