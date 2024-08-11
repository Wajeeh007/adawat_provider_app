import 'package:flutter/material.dart';

class TitleAndTextRow extends StatelessWidget {
  const TitleAndTextRow({
    super.key,
    required this.title,
    this.text,
    this.textMaxLines = 1,
    this.detailWidget,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.textAndTextWidgetAlignment = Alignment.centerRight,
    this.rowPadding = const EdgeInsets.only(bottom: 5.0),
  }) : assert(text != null || detailWidget != null, 'Either text or textWidget property must be provided'),
        assert(text == null || detailWidget == null, 'Cannot provide both text and textWidget property');

  final String title;
  final String? text;
  final Widget? detailWidget;
  final int? textMaxLines;
  final MainAxisAlignment mainAxisAlignment;
  final TextStyle? textStyle;
  final Alignment textAndTextWidgetAlignment;
  final EdgeInsets rowPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rowPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            title,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Align(
              alignment: textAndTextWidgetAlignment,
              child: detailWidget ?? Text(
                text!,
                maxLines: textMaxLines,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: textStyle != null ? textStyle!.copyWith(
                  fontWeight: FontWeight.w600
                ) : Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}