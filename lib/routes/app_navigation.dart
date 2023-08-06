import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();
  // static const String _tag = 'AppNavigation';

  static void back({required BuildContext context, dynamic result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }

  static void nextRoute(BuildContext context, String route) {
    context.goNamed(route);
  }
}
