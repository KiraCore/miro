import 'package:flutter/services.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';

class MemoLengthTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  MemoLengthTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newMemo = newValue.text;
    String replacedNewMemo = TxUtils.replaceMemoRestrictedChars(newMemo);

    bool memoLimitOverflowedBool = replacedNewMemo.length > maxLength;
    bool cursorAtEndBool = oldValue.selection.end == oldValue.text.length;

    if (memoLimitOverflowedBool && cursorAtEndBool) {
      String trimmedNewMemo = TxUtils.trimMemoToLength(newMemo, maxLength);
      return TextEditingValue(
        text: trimmedNewMemo,
        selection: TextSelection.collapsed(offset: trimmedNewMemo.length),
      );
    } else if (memoLimitOverflowedBool) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
