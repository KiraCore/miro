import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/amount_notification_section.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/amount_text_field.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/denomination_chip_button_list.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_controller.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';

class TokenSection extends StatefulWidget {
  final TokenSectionController tokenSectionController;
  final List<Balance> availableBalances;
  final MsgFormType msgFormType;
  final bool loading;
  final String? address;
  final VoidCallback onUpdateValidation;
  final TokenType? initialTokenType;
  final bool disabled;

  const TokenSection({
    required this.tokenSectionController,
    required this.availableBalances,
    required this.loading,
    required this.address,
    required this.onUpdateValidation,
    required this.msgFormType,
    this.initialTokenType,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenSection();
}

class _TokenSection extends State<TokenSection> {
  final TokensDropdownController _tokensDropDownController = TokensDropdownController();

  @override
  void initState() {
    if (widget.initialTokenType != null) {
      _onTokenTypeChanged(widget.initialTokenType!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.disabled || widget.loading ? 0.6 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AmountTextField(
                  disabled: textFieldDisabled,
                  textEditingController: widget.tokenSectionController.amountValueTextController,
                  onAmountChanged: _onAmountTextChanged,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: DecoratedInput(
                  childHeight: 45,
                  child: TokensDropdown(
                    controller: _tokensDropDownController,
                    msgFormType: widget.msgFormType,
                    initialTokenType: widget.initialTokenType,
                    onTokenTypeChanged: _onTokenTypeChanged,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<String?>(
            valueListenable: widget.tokenSectionController.errorMessageNotifier,
            builder: (_, String? errorMessage, __) => _buildNotificationSection(errorMessage),
          ),
          const SizedBox(height: 14),
          if (widget.tokenSectionController.sendTokenAmount != null)
            Row(
              children: <Widget>[
                const Text(
                  'Denomination',
                  style: TextStyle(
                    fontSize: 12,
                    color: DesignColors.gray2_100,
                  ),
                ),
                const SizedBox(width: 10),
                DenominationChipButtonList(
                  denominations: denominationList,
                  initialTokenDenomination: initialTokenDenomination,
                  onDenominationChanged: _onDenominationChanged,
                ),
              ],
            ),
        ],
      ),
    );
  }

  bool get textFieldDisabled {
    return widget.tokenSectionController.sendTokenAmount == null || widget.disabled;
  }

  void _onAmountTextChanged(String value) {
    widget.tokenSectionController.updateAmountValue(value);
    widget.onUpdateValidation();
  }

  Widget _buildNotificationSection(String? errorMessage) {
    return AmountNotificationSection(
      loading: widget.loading,
      errorMessage: errorMessage,
      maxTokenAmount: widget.tokenSectionController.availableTokenAmount,
    );
  }

  void _onTokenTypeChanged(TokenType tokenType) {
    setState(() {
      widget.tokenSectionController.updateTokenType(tokenType);
      widget.onUpdateValidation();
    });
  }

  List<TokenDenomination> get denominationList {
    return widget.tokenSectionController.selectedTokenType?.tokenDenominations ??
        List<TokenDenomination>.empty(growable: true);
  }

  TokenDenomination get initialTokenDenomination {
    return widget.tokenSectionController.sendTokenAmount!.tokenDenomination;
  }

  void _onDenominationChanged(TokenDenomination tokenDenomination) {
    setState(() {
      widget.tokenSectionController.updateTokenDenomination(tokenDenomination);
    });
  }
}
