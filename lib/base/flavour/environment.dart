import 'package:base_flutter/base/flavour/config/base_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/local_repositories/local_repository.dart';
import '../styles/themes/app_themes.dart';
import 'flavour.dart';

final Environment _singleton = Environment._internal();

class Environment {
  static Environment get instance => _singleton;

  Environment._internal();

  BaseConfig? _config;

  Locale? _selectedLocales;

  ThemeMode? _themeMode;

  bool isWeb = kIsWeb;
  Future<void> initConfig(Flavour environment) async {
    LocalRepository().initData();

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    _config = BaseConfig(environment);

    _selectedLocales = await _loadLocales();

    final AppThemes appTheme = AppThemes.instance;
    _themeMode = await appTheme.loadTheme();
  }

  BaseConfig get config {
    if (_config != null) {
      return _config!;
    }
    return BaseConfig(Flavour.dev);
  }

  Locale get selectedLocales {
    if (_selectedLocales != null) {
      return _selectedLocales!;
    }
    return AppLocalizations.supportedLocales.first;
  }

  ThemeMode get themeMode {
    if (_themeMode != null) {
      return _themeMode!;
    }
    return ThemeMode.system;
  }

  Future<Locale> _loadLocales() async {
    // final String? myLocale = await LocalRepository().appLocale();
    // return AppLanguages.getLocaleFromLanguage(langCode: myLocale);
    return const Locale('en');
  }
}
