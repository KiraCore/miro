import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/utils/token_utils.dart';

void main() {
  TokenAlias actualTokenAlias = const TokenAlias(
    decimals: 6,
    denoms: <String>['ukex', 'mkex'],
    name: 'Kira',
    symbol: 'KEX',
    icon: '',
    amount: '300000000000000',
  );

  test('testTokenUtils', () {
    expect(
      TokenUtils.changeDenomination(
        amount: '1',
        fromDenomination: 'KEX',
        toDenomination: 'ukex',
        tokenAlias: actualTokenAlias,
      ),
      const Balance(amount: '1000000.0', denom: 'ukex'),
    );
  });

  test('testTokenUtils', () {
    expect(
      TokenUtils.changeDenomination(
        amount: '1000000',
        fromDenomination: 'ukex',
        toDenomination: 'KEX',
        tokenAlias: actualTokenAlias,
      ),
      const Balance(amount: '1.0', denom: 'KEX'),
    );
  });
}
