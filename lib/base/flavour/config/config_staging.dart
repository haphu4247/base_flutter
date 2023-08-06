import 'package:base_flutter/base/flavour/flavour.dart';

import 'base_config.dart';

class StagingConfig implements BaseConfig {
  StagingConfig(this.env);

  @override
  String get apiHost => 'https://phuhp.com';

  @override
  bool get showBanner => false;

  @override
  Flavour env;
}
