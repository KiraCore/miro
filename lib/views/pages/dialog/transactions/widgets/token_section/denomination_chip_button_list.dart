import 'package:flutter/material.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/widgets/kira/kira_chip_button.dart';

typedef TokenDenominationChangedCallback = void Function(TokenDenomination tokenDenomination);

class DenominationChipButtonList extends StatefulWidget {
  final List<TokenDenomination> denominations;
  final TokenDenominationChangedCallback onDenominationChanged;
  final TokenDenomination? initialTokenDenomination;

  const DenominationChipButtonList({
    required this.denominations,
    required this.onDenominationChanged,
    this.initialTokenDenomination,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DenominationChipButtonList();
}

class _DenominationChipButtonList extends State<DenominationChipButtonList> {
  late TokenDenomination? _selectedDenomination = widget.initialTokenDenomination;

  @override
  void didUpdateWidget(covariant DenominationChipButtonList oldWidget) {
    if (oldWidget.initialTokenDenomination != widget.initialTokenDenomination) {
      _selectedDenomination = widget.initialTokenDenomination;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: widget.denominations.map((TokenDenomination tokenDenomination) {
        return KiraChipButton(
          margin: const EdgeInsets.only(right: 8),
          selected: _selectedDenomination == tokenDenomination,
          label: tokenDenomination.name,
          onTap: () => _onDenominationChanged(tokenDenomination),
        );
      }).toList(),
    );
  }

  void _onDenominationChanged(TokenDenomination tokenDenomination) {
    widget.onDenominationChanged(tokenDenomination);
    setState(() {
      _selectedDenomination = tokenDenomination;
    });
  }
}
