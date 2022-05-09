import 'dart:math';

import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/utils/app_logger.dart';

class TokenUtils {
  static String changeDenomination({
    required String amount,
    required String fromDenomination,
    required String toDenomination,
    required TokenAlias tokenAlias,
  }) {
    try {
      double tokenAmount = double.parse(amount);
      int currentDecimals = _findDecimalsForSymbol(symbol: fromDenomination, tokenAlias: tokenAlias);
      int requiredDecimals = _findDecimalsForSymbol(symbol: toDenomination, tokenAlias: tokenAlias);
      int decimals = requiredDecimals - currentDecimals;
      double parsedTokenAmount = tokenAmount * pow(10, decimals * -1).toDouble();
      return '$parsedTokenAmount';
    } catch (e) {
      AppLogger().log(message: 'Cannot parse token amount (${amount} ${fromDenomination}) to ${toDenomination}');
    }
    return '0';
  }

  static int _findDecimalsForSymbol({
    required String symbol,
    required TokenAlias tokenAlias,
  }) {
    if (symbol == tokenAlias.symbol) {
      return tokenAlias.decimals;
    } else if (symbol == tokenAlias.lowestDenomination) {
      return 0;
    }
    AppLogger().log(message: 'Cannot find decimals for symbol: $symbol');
    return 0;
  }
}
