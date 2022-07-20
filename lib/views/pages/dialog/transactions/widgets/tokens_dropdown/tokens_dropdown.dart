import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_button.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_list.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';

class TokensDropdown extends StatefulWidget {
  final WalletAddress? senderWalletAddress;
  final MsgFormType msgFormType;
  final ValueChanged<TokenAliasModel> onChanged;
  final TokenAliasModel? initialTokenAliasModel;

  const TokensDropdown({
    required this.senderWalletAddress,
    required this.msgFormType,
    required this.onChanged,
    this.initialTokenAliasModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokensDropdown();
}

class _TokensDropdown extends State<TokensDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();
  TokenAliasModel? selectedTokenAliasModel;

  @override
  void initState() {
    super.initState();
    selectedTokenAliasModel = widget.initialTokenAliasModel;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return PopWrapper(
          buttonWidth: constraints.maxWidth,
          buttonHeight: constraints.maxHeight,
          popWrapperController: popWrapperController,
          buttonBuilder: _buildDropdownButton,
          dropdownMargin: 0,
          decoration: BoxDecoration(
            color: const Color(0xFF12143D),
            borderRadius: BorderRadius.circular(8),
          ),
          popupBuilder: () => _buildPopupContent(constraints),
        );
      },
    );
  }

  Widget _buildDropdownButton(AnimationController animationController) {
    return TokenDropdownButton(
      tokenAliasModel: selectedTokenAliasModel,
    );
  }

  Widget _buildPopupContent(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: constraints.maxWidth + 20,
      height: 150,
      child: TokensDropdownList(
        onChanged: _handleTokenAliasModelSelected,
        msgFormType: widget.msgFormType,
      ),
    );
  }

  void _handleTokenAliasModelSelected(TokenAliasModel tokenAliasModel) {
    selectedTokenAliasModel = tokenAliasModel;
    popWrapperController.toggleMenu();
    widget.onChanged.call(tokenAliasModel);
    setState(() {});
  }
}
