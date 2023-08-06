import 'package:base_flutter/shared/languages/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../base/api_client/api_exception.dart';
import '../../decoration/my_spacer.dart';
import '../buttons/my_app_button.dart';

enum AppAlertType { error, success, normal }

/// Alert dialog with background image, body, cancel & ok buttons
class AppAlertDialog {
  static void showAPIError(BuildContext context, dynamic e) {
    if (e is APIException) {
      AppAlertDialog.show(
          context: context, body: e.toString(), type: AppAlertType.error);
    } else if (e is String) {
      AppAlertDialog.show(context: context, body: e, type: AppAlertType.error);
    }
  }

  static Future<void> show(
      {required BuildContext context,
      required String body,
      String? title,
      Widget? additionalBody,
      AppAlertType? type = AppAlertType.normal,
      String? accept,
      void Function()? acceptAction,
      bool hasCancelButton = false,
      bool dismissable = true,
      String? cancel,
      void Function()? cancelAction}) async {
    accept ??= context.localize.ok;
    cancel ??= context.localize.cancel;
    title ??= context.localize.notification;
    return showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => dismissable,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        spacer15,
                        Text(
                          body,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        if (additionalBody != null) additionalBody,
                        spacer20,
                        Row(
                          children: [
                            if (hasCancelButton) ...[
                              Expanded(
                                  child: MyAppButton.outline(
                                onTap: () {
                                  if (dismissable) {
                                    // AppNavigation.back();
                                  }
                                  cancelAction?.call();
                                },
                                title: cancel!,
                              )),
                              spacer15
                            ],
                            Expanded(
                              child: MyAppButton.small(
                                onTap: () {
                                  if (dismissable) {
                                    // AppNavigation.back();
                                  }
                                  acceptAction?.call();
                                },
                                title: accept!,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
