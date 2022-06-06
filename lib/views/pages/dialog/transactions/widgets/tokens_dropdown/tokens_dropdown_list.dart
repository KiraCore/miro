import 'package:flutter/material.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_list_item.dart';

typedef TokenTypeSelectedCallback = void Function(TokenType tokenType);

class TokensDropdownList extends StatefulWidget {
  final TokenTypeSelectedCallback onTokenTypeSelected;
  final MsgFormType msgFormType;

  const TokensDropdownList({
    required this.onTokenTypeSelected,
    required this.msgFormType,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokensDropdownList();
}

class _TokensDropdownList extends State<TokensDropdownList> {
  List<TokenType> tokenTypesList = List<TokenType>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    // TODO(dominik): Mocked values. Connect list with infra
    tokenTypesList = <TokenType>[
      TokenType(
        name: 'KEX',
        lowestTokenDenomination: const TokenDenomination(name: 'ukex', decimals: 0),
        defaultTokenDenomination: const TokenDenomination(name: 'KEX', decimals: 6),
      ),
      TokenType(
        name: 'LUNC',
        lowestTokenDenomination: const TokenDenomination(name: 'LUNC', decimals: 0),
      ),
      TokenType(
        name: 'ETC',
        lowestTokenDenomination: const TokenDenomination(name: 'GWEI', decimals: 0),
        defaultTokenDenomination: const TokenDenomination(name: 'ETC', decimals: 9),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tokenTypesList.length,
      itemBuilder: (BuildContext context, int index) {
        TokenType tokenType = tokenTypesList[index];
        return TokensDropdownListItem(
          tokenType: tokenType,
          onTap: () => widget.onTokenTypeSelected(tokenType),
        );
      },
    );
  }
}
