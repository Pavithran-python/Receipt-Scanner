import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<File?> compressImage({required File originalFile}) async {
  final targetDir = await getTemporaryDirectory();
  final targetPath = path.join(targetDir.path, '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg');

  int quality = 90;
  File? result;

  while (quality > 10) {
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      originalFile.absolute.path,
      minWidth: 1024,
      minHeight: 1024,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    if (compressedBytes == null) return null;

    if (compressedBytes.lengthInBytes < 500 * 1024) {
      result = File(targetPath)..writeAsBytesSync(compressedBytes);
      break;
    }

    quality -= 10;
  }

  return result;
}
