import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Text text;
  final Widget Function(double width) overflowBuilder;

  const CustomText({
    required this.text,
    required this.overflowBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) {
          final TextPainter painter = TextPainter(
            maxLines: 1,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            text: TextSpan(style: text.style ?? DefaultTextStyle.of(context).style, text: text.data),
          )..layout(maxWidth: size.maxWidth);

          return painter.didExceedMaxLines ? overflowBuilder(painter.width) : text;
        },
      ),
    );
  }
}
