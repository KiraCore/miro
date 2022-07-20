import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_list_item.dart';

class TokensDropdownList extends StatefulWidget {
  final ValueChanged<TokenAliasModel> onChanged;
  final MsgFormType msgFormType;

  const TokensDropdownList({
    required this.onChanged,
    required this.msgFormType,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokensDropdownList();
}

class _TokensDropdownList extends State<TokensDropdownList> {
  List<TokenAliasModel> tokenAliasModelList = List<TokenAliasModel>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    // TODO(dominik): Mocked values. Connect list with infra
    tokenAliasModelList = <TokenAliasModel>[
      TokenAliasModel.local('LUNA'),
      TokenAliasModel.local('LUNC'),
      TokenAliasModel.local('USDT'),
      TokenAliasModel.local('USDC'),
      TokenAliasModel.local('BUSD'),
      TokenAliasModel(
        name: 'Kira',
        lowestTokenDenomination: const TokenDenomination(name: 'ukex', decimals: 0),
        defaultTokenDenomination: const TokenDenomination(name: 'KEX', decimals: 6),
      ),
      TokenAliasModel(
        name: 'Bitcoin',
        lowestTokenDenomination: const TokenDenomination(name: 'satoshi', decimals: 0),
        defaultTokenDenomination: const TokenDenomination(name: 'BTC', decimals: 8),
      ),
      TokenAliasModel(
        name: 'Etherum',
        lowestTokenDenomination: const TokenDenomination(name: 'wei', decimals: 0),
        defaultTokenDenomination: const TokenDenomination(name: 'ETH', decimals: 18),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tokenAliasModelList.length,
      itemBuilder: (BuildContext context, int index) {
        TokenAliasModel tokenAliasModel = tokenAliasModelList[index];
        return TokensDropdownListItem(
          tokenAliasModel: tokenAliasModel,
          onTap: () => widget.onChanged(tokenAliasModel),
        );
      },
    );
  }
}
