import 'package:flutter/material.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_button.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/tokens_dropdown/tokens_dropdown_list.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';

class TokensDropdown extends StatefulWidget {
  final TokensDropdownController controller;
  final MsgFormType msgFormType;
  final void Function(TokenType) onTokenTypeChanged;
  final TokenType? initialTokenType;

  const TokensDropdown({
    required this.controller,
    required this.msgFormType,
    required this.onTokenTypeChanged,
    this.initialTokenType,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokensDropdown();
}

class _TokensDropdown extends State<TokensDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();
  final ValueNotifier<TokenType?> selectedTokenTypeNotifier = ValueNotifier<TokenType?>(null);

  @override
  void initState() {
    super.initState();
    selectedTokenTypeNotifier.value = widget.initialTokenType;
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
    return ValueListenableBuilder<TokenType?>(
      valueListenable: selectedTokenTypeNotifier,
      builder: (_, TokenType? selectedTokenType, __) {
        return TokenDropdownButton(
          tokenType: selectedTokenType,
        );
      },
    );
  }

  Widget _buildPopupContent(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: constraints.maxWidth + 20,
      height: 150,
      child: TokensDropdownList(
        onTokenTypeSelected: _onListItemTap,
        msgFormType: widget.msgFormType,
      ),
    );
  }

  void _onListItemTap(TokenType tokenType) {
    popWrapperController.toggleMenu();
    selectedTokenTypeNotifier.value = tokenType;
    widget.onTokenTypeChanged(tokenType);
  }
}
