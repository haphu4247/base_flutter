import 'package:base_flutter/base/base_screen/view/base_screen.dart';
import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

import 'test_lottie_controller.dart';

class TestLottieScreen extends BaseScreen<TestLottieController> {
  TestLottieScreen({super.key}) : super(controller: TestLottieController());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar.title(title: controller.title),
      body: ListView(
        children: [
          const NoDataView(),
          NoDataView.page404(),
          const LoadingView(),
          LoadingView.search()
        ],
      ),
    );
  }
}
