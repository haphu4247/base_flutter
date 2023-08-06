import 'package:base_flutter/base/base_screen/view/base_screen.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:base_flutter/shared/languages/context_extension.dart';
import 'package:base_flutter/shared/widgets/buttons/my_app_button.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:base_flutter/shared/widgets/my_auto_size_text.dart';
import 'package:flutter/material.dart';

import 'page_not_found_controller.dart';

class PageNotFoundScreen extends BaseScreen<PageNotFoundController> {
  PageNotFoundScreen({super.key}) : super(controller: PageNotFoundController());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar.title(title: controller.title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NoDataView.page404(),
          MyAutoSizeText(context.localize.page_not_found,
              style: Theme.of(context).textTheme.headlineMedium)
        ],
      ),
      bottomNavigationBar: MyAppButton.rectangle(
        title: context.localize.back,
        onTap: controller.onBack,
        btnPadding: const EdgeInsets.symmetric(vertical: 28),
      ),
    );
  }
}
