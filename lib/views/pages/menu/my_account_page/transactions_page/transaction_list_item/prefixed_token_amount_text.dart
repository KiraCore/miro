import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';

class PrefixedTokenAmountText extends StatelessWidget {
  final PrefixedTokenAmountModel prefixedTokenAmountModel;
  final TextAlign textAlign;
  final TextStyle textStyle;

  const PrefixedTokenAmountText({
    required this.prefixedTokenAmountModel,
    required this.textAlign,
    required this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String prefixedTokenAmountString = prefixedTokenAmountModel.toString();

    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) {
          TextPainter painter = TextPainter(
            maxLines: 1,
            textAlign: textAlign,
            textDirection: TextDirection.ltr,
            text: TextSpan(style: textStyle, text: prefixedTokenAmountString),
          )..layout(maxWidth: size.maxWidth);

          if (painter.didExceedMaxLines) {
            return Text(
              _buildShortString(size.maxWidth),
              textAlign: textAlign,
              style: textStyle,
            );
          } else {
            return Text(
              prefixedTokenAmountString,
              textAlign: textAlign,
              style: textStyle,
            );
          }
        },
      ),
    );
  }

  String _buildShortString(double maxWidth) {
    String prefix = '${prefixedTokenAmountModel.getPrefix()} >';
    StringBuffer valueText = StringBuffer('9');
    String denom = prefixedTokenAmountModel.getDenominationName();

    String finalText = '$prefix$valueText $denom';

    bool maxValueFoundBool = false;
    while (maxValueFoundBool == false) {
      valueText.write('9');
      String newFinalText = '$prefix$valueText $denom';

      TextPainter painter = TextPainter(
        maxLines: 1,
        textAlign: textAlign,
        textDirection: TextDirection.ltr,
        text: TextSpan(style: textStyle, text: newFinalText),
      )..layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines) {
        maxValueFoundBool = true;
      } else {
        finalText = newFinalText;
      }
    }

    return finalText;
  }
}
