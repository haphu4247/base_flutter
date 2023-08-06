import 'package:flutter/animation.dart';

import 'base_controller.dart';

abstract class BaseStatefulController extends BaseController {
  void initState(
    TickerProvider? vsync,
  );
  // Function? onRebuildView(BuildContext context);
  void dispose();
}
