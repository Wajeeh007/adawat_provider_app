import 'package:flutter/material.dart';

/// Title is small and Text is large
class TitleAndTextColumn extends StatelessWidget {
  const TitleAndTextColumn({
    super.key,
    required this.title,
    this.text,
    this.detailWidget,
    this.crossAxisAlignment
  }) : assert(text != null || detailWidget != null, 'Both text and details property cannot be null'),
      assert(text == null || detailWidget == null, 'Cannot provide both text and details property. Remove one of the two');

  final String title;
  final String? text;
  final Widget? detailWidget;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.grey.shade400
          ),
        ),
        const SizedBox(height: 5,),
        detailWidget == null ? text != null ? Text(
          text!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600
          ),
        ) : const SizedBox() : detailWidget!
      ],
    );
  }
}