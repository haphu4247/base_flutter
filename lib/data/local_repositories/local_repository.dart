// part 'package:cinema/app/data/local_repositories/local_data_key/local_data_key.dart';
import 'package:base_flutter/base/cached/base_local_data_key_ext.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../base/models/cached_response_model.dart';
import 'local_data_key/local_data_key_impl.dart';

class LocalRepository {
  static final LocalRepository _singleton = LocalRepository._internal();
  factory LocalRepository() {
    return _singleton;
  }
  LocalRepository._internal();

  Future<void> initData() async {
    await _initHive();
  }

  Future<bool> clearData() {
    return LocalDataKey.clearAll.clear();
  }

  Future<void> _initHive() async {
    if (kIsWeb) {
      return;
    }
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // Hive.init(appDocPath);
    // Hive.registerAdapter<AccountEntity>(AccountEntityAdapter());
    // Hive.registerAdapter<UserRole>(UserRoleAdapter());
  }

  Future<bool?> firstTimeOpenApp() {
    return LocalDataKey.bFirstTimeOpenApp.getBool();
  }

  Future<String?> appLocale() {
    return LocalDataKey.sAppLocale.getString();
  }

  Future<bool> saveFcmToken(String fcmToken) {
    return LocalDataKey.fcmToken.setString(fcmToken);
  }

  Future<bool> setAppLocale(String langCode) {
    return LocalDataKey.sAppLocale.setString(langCode);
  }

  Future<String?> appCurrency() {
    return LocalDataKey.sAppCurrency.getString();
  }

  Future<bool> setAppCurrency(String langCode) {
    return LocalDataKey.sAppCurrency.setString(langCode);
  }

  Future<ThemeMode> themes() async {
    final result = await LocalDataKey.sThemes.getString();
    if (result != null) {
      return ThemeMode.values.byName(result);
    } else {
      return ThemeMode.light;
    }
  }

  Future<bool> saveTheme(ThemeMode theme) {
    return LocalDataKey.sThemes.setString(theme.name);
  }

  Future<CachedResponseModel?> read(String key) async {
    return LocalDataKeyExt.read<CachedResponseModel>(
        key, CachedResponseModel());
  }

  void save(String key, CachedResponseModel value) {
    LocalDataKeyExt.save<CachedResponseModel>(key, value);
  }
}
