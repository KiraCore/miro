import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';
import 'package:miro/views/widgets/kira/kira_chip_button.dart';

class DenominationChipButtonList extends StatefulWidget {
  final ValueChanged<TokenDenomination> onChanged;
  final TokenAliasModel tokenAliasModel;

  const DenominationChipButtonList({
    required this.onChanged,
    required this.tokenAliasModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DenominationChipButtonList();
}

class _DenominationChipButtonList extends State<DenominationChipButtonList> {
  late TokenDenomination? selectedDenomination;

  @override
  void initState() {
    super.initState();
    _updateInitialTokenDenomination();
  }

  @override
  void didUpdateWidget(covariant DenominationChipButtonList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tokenAliasModel != widget.tokenAliasModel) {
      _updateInitialTokenDenomination();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Denomination',
          style: TextStyle(
            fontSize: 12,
            color: DesignColors.gray2_100,
          ),
        ),
        const SizedBox(width: 10),
        Wrap(
          direction: Axis.horizontal,
          children: availableDenominations.map((TokenDenomination tokenDenomination) {
            return KiraChipButton(
              margin: const EdgeInsets.only(right: 8),
              selected: selectedDenomination == tokenDenomination,
              label: tokenDenomination.name,
              onTap: () => _handleTokenDenominationChanged(tokenDenomination),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _updateInitialTokenDenomination() {
    selectedDenomination = widget.tokenAliasModel.lowestTokenDenomination;
  }

  List<TokenDenomination> get availableDenominations => widget.tokenAliasModel.tokenDenominations;

  void _handleTokenDenominationChanged(TokenDenomination tokenDenomination) {
    widget.onChanged.call(tokenDenomination);
    selectedDenomination = tokenDenomination;
    setState(() {});
  }
}
