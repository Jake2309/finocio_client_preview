import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:stockolio/helpers/definitions.dart';
import 'package:stockolio/model/device/device_info.dart';

class DeviceManager {
  static String currentPlatform = _getCurrentPlatform();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static String _getCurrentPlatform() {
    if (Platform.isAndroid) {
      return Definition.ANDROID_PLATFORM;
    }

    if (Platform.isIOS) {
      return Definition.IOS_PLATFORM;
    }

    return Definition.UNKNOW_PLATFORM;
  }

  static Future<DeviceInfo>? getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        var androidDevice = await deviceInfoPlugin.androidInfo;
        return new DeviceInfo(
          id: androidDevice.id,
          model: androidDevice.model,
          device: androidDevice.device,
          manufacturer: androidDevice.manufacturer,
          platform: androidDevice.product,
        );
      } else if (Platform.isIOS) {
        var iosDevice = await deviceInfoPlugin.iosInfo;
        return new DeviceInfo(
          id: iosDevice.identifierForVendor,
          model: iosDevice.model,
          platform: iosDevice.name,
        );
      }
    } catch (e) {
      throw e;
    }

    throw Exception('Device unsupported');
    // return null;
  }
}
