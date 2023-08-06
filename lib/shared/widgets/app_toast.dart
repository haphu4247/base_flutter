import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colors/app_colors.dart';
import '../utils/utils.dart';

enum ToastType { success, removed, error, warning, info, added }

extension ToastTypeExt on ToastType {
  Color getColor() {
    switch (this) {
      case ToastType.success:
      case ToastType.removed:
        return AppColors.oke;
      case ToastType.error:
        return AppColors.failed;
      case ToastType.warning:
        return AppColors.warning;
      case ToastType.info:
      case ToastType.added:
        return AppColors.primary;
    }
  }

  IconData iconData() {
    switch (this) {
      case ToastType.success:
      case ToastType.removed:
        return Icons.celebration;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.back_hand;
      case ToastType.info:
      case ToastType.added:
        return Icons.bookmark_added;
    }
  }
}

class MyToast {
  late final FToast _fToast;

  static final MyToast instance = MyToast._internal();

  /// Prmary Constructor for FToast
  factory MyToast() {
    return instance;
  }

  /// Take users Context and saves to avariable
  MyToast initToast(BuildContext context) {
    _fToast = FToast();
    _fToast.init(context);
    return instance;
  }

  MyToast._internal();

  void showToast(
    ToastType type,
    String text,
    String subText, {
    VoidCallback? onClose,
  }) {
    _fToast.showToast(
      child: _MyCustomToast(
          onClose: onClose, type: type, text: text, subText: subText),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 1),
    );
  }
}

class _MyCustomToast extends StatelessWidget {
  const _MyCustomToast(
      {Key? key,
      this.onClose,
      required this.type,
      required this.text,
      required this.subText})
      : super(key: key);
  final ToastType type;
  final String text;
  final String subText;
  final VoidCallback? onClose;
  @override
  Widget build(BuildContext context) {
    final color = type.getColor();
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: const [0.02, 0.02], colors: [color, Colors.white]),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Row(
          children: [
            Padding(
              padding: Utils.paddingHorizontal(context, padding: 20),
              child: Icon(
                type.iconData(),
                color: color,
                size: Utils.width(context, 20),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: Utils.paddingVertical(context, padding: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: Utils.height(context, 30),
                      child: Text(
                        subText,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: onClose,
                icon: Icon(Icons.close,
                    size: Utils.width(context, 15), color: AppColors.primary))
          ],
        ),
      ),
    );
  }
}
