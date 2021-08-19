import 'dart:typed_data';
import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';

class QRManager {

  Future<ByteData> createQRImage(String data) async {
    QrValidationResult result = _generateQRCode(data);
    ByteData imageData =  await _getQRImageData(result);
    return imageData;
  }

  QrValidationResult _generateQRCode(String data) {
    return  QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
  }

  Future<ByteData> _getQRImageData(QrValidationResult qr) async {
    final painter = QrPainter.withQr(
      qr: qr.qrCode,
      color: const Color(0xFF000000),
      emptyColor: const Color.fromRGBO(255, 255, 255, 1),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    ByteData data =  await painter.toImageData(2048, format: ImageByteFormat.png);
    return data;
  }
}