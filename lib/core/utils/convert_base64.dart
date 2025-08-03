import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> convertBase64ToFile({required String imageBase64,required int getId}) async {
  final bytes = base64Decode(imageBase64);
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$getId.jpg');
  await file.writeAsBytes(bytes);
  return file;
}