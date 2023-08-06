import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:base_flutter/routes/app_navigation.dart';

class PageNotFoundController extends BaseController {
  String get title => '404';

  void onBack() {
    AppNavigation.back(context: context);
  }
}
