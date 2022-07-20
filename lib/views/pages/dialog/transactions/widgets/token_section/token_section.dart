import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/amount_notification_section.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/amount_text_field.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/denomination_chip_button_list.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_layout.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';

class TokenSection extends StatefulWidget {
  final WalletAddress? senderWalletAddress;
  final bool disabled;
  final MsgFormType msgFormType;
  final ValueChanged<TokenAmount?> onChanged;
  final TokenAliasModel? initialTokenAliasModel;
  final TokenSectionController tokenSectionController;

  TokenSection({
    required this.senderWalletAddress,
    required this.disabled,
    required this.msgFormType,
    required this.onChanged,
    this.initialTokenAliasModel,
    TokenSectionController? tokenSectionController,
    Key? key,
  })  : tokenSectionController = tokenSectionController ?? TokenSectionController(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenSection();
}

class _TokenSection extends State<TokenSection> {
  @override
  void initState() {
    super.initState();
    widget.tokenSectionController.addListener(_handleTokenSectionControllerChangedValue);
  }

  @override
  Widget build(BuildContext context) {
    return TokenSectionLayout(
      hasTransparentOverlay: widget.disabled,
      amountTextFieldWidget: ValueListenableBuilder<TokenAmount?>(
        valueListenable: widget.tokenSectionController.tokenAmountNotifier,
        builder: (_, TokenAmount? tokenAmount, __) {
          return AmountTextField(
            disabled: tokenAmount == null,
            textEditingController: widget.tokenSectionController.amountTextEditingController,
            onChanged: _handleAmountChanged,
            onError: _handleError,
          );
        },
      ),
      tokensDropdownWidget: DecoratedInput(
        childHeight: 45,
        child: TokensDropdown(
          senderWalletAddress: widget.senderWalletAddress,
          msgFormType: widget.msgFormType,
          initialTokenAliasModel: widget.initialTokenAliasModel,
          onChanged: _handleTokenAliasModelChanged,
        ),
      ),
      notificationSectionWidget: ValueListenableBuilder<String?>(
          valueListenable: widget.tokenSectionController.errorNotifier,
          builder: (_, String? errorMessage, __) {
            return AmountNotificationSection(
              errorMessage: errorMessage,
              // maxTokenAmount: widget.tokenSectionController.availableTokenAmount,
            );
          }),
      denominationWidget: ValueListenableBuilder<TokenAmount?>(
        valueListenable: widget.tokenSectionController.tokenAmountNotifier,
        builder: (_, TokenAmount? tokenAmount, __) {
          if (tokenAmount == null) {
            return const SizedBox();
          }
          return DenominationChipButtonList(
            tokenAliasModel: tokenAmount.tokenAliasModel,
            onChanged: _handleDenominationChanged,
          );
        },
      ),
    );
  }

  void _handleTokenSectionControllerChangedValue() {
    TokenAmount? selectedTokenAmount = widget.tokenSectionController.tokenAmountNotifier.value;
    widget.onChanged.call(selectedTokenAmount);
  }

  void _handleAmountChanged(Decimal amount) {
    widget.tokenSectionController.setAmount(amount);
  }

  void _handleTokenAliasModelChanged(TokenAliasModel tokenAliasModel) {
    widget.tokenSectionController.setTokenAliasModel(tokenAliasModel);
  }

  void _handleDenominationChanged(TokenDenomination tokenDenomination) {
    widget.tokenSectionController.setTokenDenomination(tokenDenomination);
  }

  void _handleError(String error) {
    widget.tokenSectionController.setError(error);
  }
}
