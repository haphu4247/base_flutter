import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:base_flutter/base/flavour/environment.dart';
import 'package:base_flutter/routes/app_navigation.dart';
import 'package:base_flutter/shared/languages/context_extension.dart';

class HomeController extends BaseController {
  String get title {
    final env =
        context.localize.appVariant(Environment.instance.config.env.name);
    return 'Home $env';
  }

  void gotoTest(String route) {
    AppNavigation.nextRoute(context, route);
  }
}
