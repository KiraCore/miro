import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TxUtils {
  static Map<String, String> memoReplacements = <String, String>{
    '<': r'\u003c',
    '>': r'\u003e',
  };

  static String buildAmountString(String amount, TokenDenominationModel? tokenDenominationModel) {
    int decimals = (tokenDenominationModel == null) ? 0 : tokenDenominationModel.decimals;
    bool amountNotZeroBool = amount != '0' && amount != '0.';
    bool noDecimalPointBool = amount.contains('.') == false;
    bool divisibleBool = decimals > 0;

    if (amountNotZeroBool && divisibleBool) {
      if (noDecimalPointBool) {
        return '$amount.0';
      } else if (amount.startsWith('.')) {
        return '0$amount';
      } else if (amount.endsWith('.')) {
        return '${amount}0';
      } else {
        return amount;
      }
    } else {
      return amount;
    }
  }

  static String trimMemoToLength(String rawMemo, int maxLength) {
    String trimmedMemo = rawMemo;
    String replacedMemo = TxUtils.replaceMemoRestrictedChars(trimmedMemo);
    while (replacedMemo.length > maxLength) {
      trimmedMemo = trimmedMemo.substring(0, trimmedMemo.length - 1);
      replacedMemo = TxUtils.replaceMemoRestrictedChars(trimmedMemo);
    }
    return trimmedMemo;
  }

  // TODO(dominik): Rename to replaceRestrictedChars
  static String replaceMemoRestrictedChars(String memo) {
    String replacedMemo = memo;
    memoReplacements.forEach((String pattern, String replacement) {
      replacedMemo = replacedMemo.replaceAll(pattern, replacement);
    });
    return replacedMemo;
  }
}
