import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/views/widgets/kira/kira_chip_button.dart';

class TokenDenominationList extends StatefulWidget {
  final ValueChanged<TokenDenominationModel> onChanged;
  final TokenDenominationModel? defaultTokenDenominationModel;
  final TokenAliasModel? tokenAliasModel;

  const TokenDenominationList({
    required this.onChanged,
    this.defaultTokenDenominationModel,
    this.tokenAliasModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenDenominationList();
}

class _TokenDenominationList extends State<TokenDenominationList> {
  TokenDenominationModel? selectedTokenDenominationModel;

  @override
  void initState() {
    super.initState();
    selectedTokenDenominationModel = widget.defaultTokenDenominationModel ?? widget.tokenAliasModel?.defaultTokenDenominationModel;
  }

  @override
  void didUpdateWidget(covariant TokenDenominationList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tokenAliasModel != widget.tokenAliasModel) {
      selectedTokenDenominationModel = widget.tokenAliasModel?.defaultTokenDenominationModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<TokenDenominationModel> tokenDenominations = List<TokenDenominationModel>.empty();
    if (widget.tokenAliasModel?.tokenDenominations != null) {
      tokenDenominations = widget.tokenAliasModel!.tokenDenominations;
    }
    if (tokenDenominations.isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: <Widget>[
        Text(
          'Denomination',
          style: textTheme.caption!.copyWith(
            color: DesignColors.gray2_100,
          ),
        ),
        const SizedBox(width: 10),
        ...tokenDenominations.map(
          (TokenDenominationModel tokenDenominationModel) {
            return KiraChipButton(
              label: tokenDenominationModel.name,
              margin: const EdgeInsets.only(right: 8),
              selected: selectedTokenDenominationModel == tokenDenominationModel,
              onTap: () => _handleTokenDenominationModelChanged(tokenDenominationModel),
            );
          },
        ).toList(),
      ],
    );
  }

  void _handleTokenDenominationModelChanged(TokenDenominationModel tokenDenominationModel) {
    selectedTokenDenominationModel = tokenDenominationModel;
    widget.onChanged(tokenDenominationModel);
    setState(() {});
  }
}
