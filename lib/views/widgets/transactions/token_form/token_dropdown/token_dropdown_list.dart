import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_list_item.dart';

class TokenDropdownList extends StatefulWidget {
  final TokenAliasModel? initialTokenAliasModel;
  final ValueChanged<BalanceModel> onBalanceModelSelected;
  final WalletAddress? walletAddress;

  const TokenDropdownList({
    required this.initialTokenAliasModel,
    required this.onBalanceModelSelected,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenDropdownList();
}

class _TokenDropdownList extends State<TokenDropdownList> {
  TokenAliasModel? selectedTokenAliasModel;

  @override
  void initState() {
    super.initState();
    selectedTokenAliasModel = widget.initialTokenAliasModel;
  }

  @override
  Widget build(BuildContext context) {
    // TODO(dominik): Remove after implement logic
    TokenAlias kexTokenAlias = const TokenAlias(
      decimals: 6,
      denoms: <String>['ukex', 'mkex'],
      name: 'Kira',
      symbol: 'KEX',
      icon: '',
      amount: '3000000000',
    );

    List<BalanceModel> mockBalanceModelList = <BalanceModel>[
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(55000000),
          tokenAliasModel: TokenAliasModel.fromDto(kexTokenAlias),
        ),
      ),
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(1012546),
          tokenAliasModel: const TokenAliasModel(
            name: 'Etherum',
            lowestTokenDenominationModel: TokenDenominationModel(name: 'wei', decimals: 0),
            defaultTokenDenominationModel: TokenDenominationModel(name: 'ETH', decimals: 18),
          ),
        ),
      ),
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(1321555),
          tokenAliasModel: TokenAliasModel.local('samolean'),
        ),
      ),
    ];

    return ListView.builder(
      itemCount: mockBalanceModelList.length,
      itemBuilder: (BuildContext context, int index) {
        BalanceModel balanceModel = mockBalanceModelList[index];
        TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
        return TokenDropdownListItem(
          tokenAliasModel: tokenAliasModel,
          selected: selectedTokenAliasModel == tokenAliasModel,
          onTap: () => _handleItemSelected(balanceModel),
          favourite: balanceModel.isFavourite,
        );
      },
    );
  }

  void _handleItemSelected(BalanceModel balanceModel) {
    selectedTokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
    widget.onBalanceModelSelected.call(balanceModel);
    setState(() {});
  }
}
