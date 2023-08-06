import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MyAutoSizeText extends StatelessWidget {
  const MyAutoSizeText(this.text,
      {Key? key,
      required this.style,
      this.maxLines = 16,
      this.textAlign = TextAlign.center})
      : super(key: key);
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      minFontSize: 10,
    );
  }
}
