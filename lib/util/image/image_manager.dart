import 'dart:io';
import 'dart:typed_data';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImageManager {

  Future<bool> saveImageToGallery(ByteData data, String fileName) async {
    final String path = await _generateTempFile(fileName);
    await _writeImageFile(data, path);
    bool result =  await _exportToGallery(path);
    return result;
  }

  Future<String> _generateTempFile(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    fileName = fileName.trim();
    print('$tempPath/$ts-$fileName.png');
    return '$tempPath/$ts-$fileName.png';
  }

  Future<void> _writeImageFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
    );
  }

  Future<bool> _exportToGallery(String path) async {
    bool result = await GallerySaver.saveImage(path);
    print(result);
    return result;
  }

}