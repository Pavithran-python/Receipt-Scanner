import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/sizes.dart';

Future<File?> compressImage({required File originalFile}) async {
  final targetDir = await getTemporaryDirectory();
  final targetPath = path.join(targetDir.path, '${DateTime.now().millisecondsSinceEpoch}$compressed');

  int quality = AppSizes.imageQuality;
  File? result;

  while (quality > AppSizes.imageQualityCheck) {
    final compressedBytes = await FlutterImageCompress.compressWithFile(
      originalFile.absolute.path,
      minWidth: AppSizes.imageSize,
      minHeight: AppSizes.imageSize,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    if (compressedBytes == null) return null;

    if (compressedBytes.lengthInBytes < AppSizes.imageReduceSize * AppSizes.imageSize) {
      result = File(targetPath)..writeAsBytesSync(compressedBytes);
      break;
    }

    quality -= AppSizes.imageReduceQualityCheck;
  }

  return result;
}
