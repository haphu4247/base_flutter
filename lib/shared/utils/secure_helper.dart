import 'package:package_info_plus/package_info_plus.dart';

import 'my_log.dart';

class SecureHelper {
  SecureHelper._();

  static final SecureHelper instance = SecureHelper._();

  Future<PackageInfo> get packageInfo async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    // packageInfo.buildSignature;
    MyLogger.d(this, 'buildSignature: ${packageInfo.buildSignature}');
    return packageInfo;
  }
}
