import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

// Service that doesn't depend on an authenticated user
@singleton
class SystemService {
  // GENERAL App and Phone Info
  // Package Info
  String appName;
  String packageName;
  String version;
  String buildNumber;

  // Device Info
  String device;
  String os; // Will be
  String osVersion;

  //Screen size
  double screenWidth;
  double screenHeight;

  // Run all system setup operations that do not require a context
  Future<void> runSystemSetup() async {
    await getPlatformInfo();
    await getDeviceInfo();
  }

  void runContextSetup(BuildContext context) {
    getScreenSize(context);
  }

  Future<void> getPlatformInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    // Android
    if (deviceInfo.androidInfo != null) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      device = androidInfo.model;
      os = "Android";
      osVersion = androidInfo.version.release;
    }
    // iOS
    else if (deviceInfo.iosInfo != null) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      device = iosInfo.model;
      os = "iOS";
      osVersion = iosInfo.systemVersion;
    }
  }

  void getScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
