import 'package:flutter/material.dart';
import 'package:crashid/core/utils/html_text_extractor.dart';

class HtmlTextWidget extends StatelessWidget {
  final String? htmlContent;

  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool normalizeWhitespace;
  final VoidCallback? onTap;

  const HtmlTextWidget( {
    Key? key,
    this.htmlContent,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.normalizeWhitespace = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extractedText = HtmlTextExtractor.extractText(
      htmlContent ?? '',
      normalizeWhitespace: normalizeWhitespace,
    );

    final textWidget = Text(
      extractedText,
      style: textStyle,
      textAlign: textAlign,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: textWidget,
      );
    }

    return textWidget;
  }
}
