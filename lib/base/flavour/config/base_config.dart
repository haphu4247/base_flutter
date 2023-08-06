import 'package:base_flutter/base/flavour/flavour.dart';

import 'config_prod.dart';
import 'config_staging.dart';

abstract class BaseConfig {
  factory BaseConfig(Flavour environment) {
    switch (environment) {
      case Flavour.prod:
        return ProdConfig(environment);
      case Flavour.dev:
      case Flavour.staging:
        return StagingConfig(environment);
    }
  }
  String get apiHost;

  bool get showBanner;

  Flavour get env;
}
