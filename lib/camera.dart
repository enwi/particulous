import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;

// import 'package:zxing2/qrcode.dart';
// import 'package:zxing_lib/common.dart';
// import 'package:zxing_lib/multi.dart';
// import 'package:zxing_lib/qrcode.dart';
// import 'package:zxing_lib/zxing.dart';
// import 'package:qr_code_vision/qr_code_vision.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:zxing2/qrcode.dart';

import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:camera_windows/camera_windows.dart';
import 'package:flutter/material.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

Uint8List toABGR(final Uint8List rgba) {
  // Check if the length of the array is a multiple of 4 (RGBA)
  if (rgba.length % 4 != 0) {
    throw ArgumentError('Invalid length for RGBA pixels');
  }

  // Create a new Uint8List for ABGR pixels
  Uint8List abgr = Uint8List(rgba.length);

  // Iterate through the original array and rearrange the values
  for (int i = 0; i < rgba.length; i += 4) {
    // ABGR order: [alpha, blue, green, red]
    abgr[i + 0] = rgba[i + 3]; // alpha
    abgr[i + 1] = rgba[i + 2]; // blue
    abgr[i + 2] = rgba[i + 1]; // green
    abgr[i + 3] = rgba[i + 0]; // red
  }

  return abgr;
}

Uint8List toARGB(final Uint8List rgba) {
  // Check if the length of the array is a multiple of 4 (RGBA)
  if (rgba.length % 4 != 0) {
    throw ArgumentError('Invalid length for RGBA pixels');
  }

  // Create a new Uint8List for ABGR pixels
  Uint8List argb = Uint8List(rgba.length);

  // Iterate through the original array and rearrange the values
  for (int i = 0; i < rgba.length; i += 4) {
    // ABGR order: [alpha, blue, green, red]
    argb[i + 0] = rgba[i + 3]; // alpha
    argb[i + 1] = rgba[i + 0]; // red
    argb[i + 2] = rgba[i + 1]; // green
    argb[i + 3] = rgba[i + 2]; // blue
  }

  return argb;
}

Uint8List toBGRA(final Uint8List rgba) {
  // Check if the length of the array is a multiple of 4 (RGBA)
  if (rgba.length % 4 != 0) {
    throw ArgumentError('Invalid length for RGBA pixels');
  }

  // Create a new Uint8List for ABGR pixels
  Uint8List argb = Uint8List(rgba.length);

  // Iterate through the original array and rearrange the values
  for (int i = 0; i < rgba.length; i += 4) {
    // ABGR order: [alpha, blue, green, red]
    argb[i + 0] = rgba[i + 2]; // blue
    argb[i + 1] = rgba[i + 1]; // green
    argb[i + 2] = rgba[i + 0]; // red
    argb[i + 3] = rgba[i + 3]; // alpha
  }

  return argb;
}

class _QRScannerState extends State<QRScanner> {
  bool _ready = false;
  late int _cameraId;
  late Size _size;
  StreamSubscription<FrameAvailabledEvent>? _cameraStream;
  final _hints = DecodeHints();
  final _reader = QRCodeReader();
  // final _reader = QRCodeReader();
  // int _counter = 0;
  // final qrCode = QrCode();

  void analyseImage(final Uint8List rgba) {
    // Stopwatch stopwatch = Stopwatch()..start();

    // LuminanceSource source = RGBLuminanceSource(_size.width.toInt(),
    //     _size.height.toInt(), toABGR(bytes).buffer.asInt32List());
    // var bitmap = BinaryBitmap(GlobalHistogramBinarizer(source));

    final source = RGBLuminanceSource(
      _size.width.toInt(),
      _size.height.toInt(),
      toBGRA(rgba).buffer.asInt32List(),
    );
    final bitmap = BinaryBitmap(HybridBinarizer(source));

    // final pixels = Uint8List(_size.width.toInt() * _size.height.toInt());
    // for (int i = 0; i < rgba.length; i += 4) {
    //   pixels[i ~/ 4] = RGBLuminanceSource.getLuminance(
    //       rgba[i + 0], rgba[i + 1], rgba[i + 2]);
    // }
    // final source = RGBLuminanceSource.orig(
    //   _size.width.toInt(),
    //   _size.height.toInt(),
    //   pixels,
    // );
    // final bitmap = BinaryBitmap(HybridBinarizer(source));

    // try {
    //   final result = _reader.decode(
    //     bitmap,
    //     const DecodeHint(
    //       tryHarder: true,
    //       alsoInverted: true,
    //       possibleFormats: [BarcodeFormat.qrCode],
    //     ),
    //   );
    //   _cameraStream!.cancel();
    //   Navigator.of(context).pop(result.text);
    // } catch (_) {}

    try {
      var result = _reader.decode(bitmap);
      // var result = _reader.decode(bitmap, hints: _hints);
      _cameraStream!.cancel();
      log(result.text);
      Navigator.of(context).pop(result.text);
    } catch (e) {
      log('Could not find QR: $e');
    }

    // try {
    //   qrCode.scanRgbaBytes(rgba, _size.width.toInt(), _size.height.toInt());

    //   if (qrCode.content != null) {
    //     log(qrCode.content!.text);
    //     Navigator.of(context).pop(qrCode.content!.text);
    //   }
    // } catch (e) {
    //   log('Could not find QR: $e');
    // }

    // log('Looking for QR codes took ${stopwatch.elapsedMilliseconds} ms');
  }

  void initAsync() async {
    _cameraId = await CameraPlatform.instance
        .availableCameras()
        .then((cameras) => cameras.last)
        .then((camera) => CameraPlatform.instance.createCamera(
              camera,
              // ResolutionPreset.max,
              ResolutionPreset.high,
              enableAudio: false,
            ));

    final Future<CameraInitializedEvent> initialized =
        CameraPlatform.instance.onCameraInitialized(_cameraId).first;
    try {
      await CameraPlatform.instance.initializeCamera(_cameraId);
    } on CameraException catch (e) {
      log('Exception while initializing camera: $e');
      return;
    }

    final CameraInitializedEvent event = await initialized;
    _size = Size(
      event.previewWidth,
      event.previewHeight,
    );
    setState(() {
      _ready = true;
    });

    _hints.put(DecodeHintType.tryHarder);
    // _hints.put(DecodeHintType.possibleFormats, [BarcodeFormat.qrCode]);

    _cameraStream = (CameraPlatform.instance as CameraWindows)
        .onFrameAvailable(_cameraId)
        .listen((event) {
      // if (_counter % 5 == 0) {
      analyseImage(event.bytes);
      // }
      // ++_counter;
    });
  }

  @override
  void initState() {
    initAsync();
    super.initState();
  }

  @override
  void dispose() {
    _cameraStream?.cancel();
    CameraPlatform.instance.dispose(_cameraId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR code'),
      ),
      body: _ready
          ?
          // Align(
          //     child: AspectRatio(
          //       aspectRatio: _size.width / _size.height,
          //       child: CameraPlatform.instance.buildPreview(_cameraId),
          //     ),
          //   )
          Align(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: AspectRatio(
                  aspectRatio: _size.width / _size.height,
                  child: CameraPlatform.instance.buildPreview(_cameraId),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

Future<String?> scanQR(BuildContext context) {
  if (Platform.isMacOS) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AiBarcodeScanner(
              canPop: false,
              onScan: (String value) {},
              onDetect: (BarcodeCapture barcodeCapture) {
                for (final code in barcodeCapture.barcodes) {
                  if ((code.rawValue?.contains('pc') ?? false) &&
                      (code.rawValue?.contains('mc') ?? false)) {
                    return Navigator.of(context).pop(code.rawValue!);
                  }
                }
              },
            )));
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const QRScanner()));
}

enum QRType { LCSC }

class QRData {
  QRType type;

  QRData({required this.type});
}

class LCSCQRData extends QRData {
  String productNumber;
  int? amount;

  LCSCQRData({required this.productNumber, this.amount})
      : super(type: QRType.LCSC);

  @override
  String toString() {
    return 'LCSCQRData($productNumber, $amount)';
  }
}

QRData? parseQR(String data) {
  // final Map<String, Object>? json = jsonDecode(data);
  // if (json == null) {
  //   return null;
  // }

  if (data.contains('pc') && data.contains('mc')) {
    // This is likely an LCSC QR code

    var start = data.indexOf('pc:') + 3;
    final productNumber = data.substring(start, data.indexOf(',', start));
    start = data.indexOf('qty:') + 4;
    final amount = int.parse(data.substring(start, data.indexOf(',', start)));

    return LCSCQRData(productNumber: productNumber, amount: amount);
  }

  return null;
}
