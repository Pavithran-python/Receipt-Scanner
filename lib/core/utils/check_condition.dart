import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/core/constants/constant.dart';

class checkCondition{

  Future<bool> checkAndRequestGalleryPermission() async {
    Permission permission;
    if (Platform.isAndroid) {
      // Use Android version-specific permission
      final sdkInt = await _getAndroidSdkInt();
      if (sdkInt >= 33) {
        permission = Permission.photos; // Android 13+
      } else {
        permission = Permission.storage; // Android 12 and below
      }
    } else {
      // iOS
      permission = Permission.photos;
    }
    final status = await permission.status;
    if (status.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }

  Future<int> _getAndroidSdkInt() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt;
  }

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) return errorDateRequired;
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value.trim())) return errorDateFormat;
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) return errorAmountRequired;
    final parsed = double.tryParse(value.trim());
    return parsed == null ? errorValidNumber : null;
  }

  String? validateItems(String? value) {
    if (value == null || value.trim().isEmpty) {
      return errorItemRequired;
    }
    final items = value.split(',').map((e) => e.trim()).toList();
    if (items.any((item) => item.isEmpty)) {
      return errorNonItem;
    }
    return null;
  }

}