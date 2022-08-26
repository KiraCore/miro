import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_cubit.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_button.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';

class TokenDropdown extends StatefulWidget {
  final bool disabled;
  final BalanceModel? initialBalanceModel;
  final WalletAddress? walletAddress;

  const TokenDropdown({
    this.disabled = false,
    this.initialBalanceModel,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenDropdown();
}

class _TokenDropdown extends State<TokenDropdown> {
  late final ValueNotifier<BalanceModel?> selectedBalanceModelNotifier = ValueNotifier<BalanceModel?>(widget.initialBalanceModel);
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return PopWrapper(
          disabled: widget.disabled,
          buttonWidth: boxConstraints.maxWidth,
          buttonHeight: 80,
          popWrapperController: popWrapperController,
          buttonBuilder: _buildSelectedTokenButton,
          dropdownMargin: 15,
          decoration: BoxDecoration(
            color: const Color(0xFF12143D),
            borderRadius: BorderRadius.circular(8),
          ),
          popupBuilder: () => _buildPopupTokensList(boxConstraints),
        );
      },
    );
  }

  Widget _buildSelectedTokenButton(AnimationController animationController) {
    return ValueListenableBuilder<BalanceModel?>(
      valueListenable: selectedBalanceModelNotifier,
      builder: (_, BalanceModel? balanceModel, __) {
        return TxInputWrapper(
          height: 80,
          disabled: widget.disabled,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: TokenDropdownButton(
              tokenAliasModel: balanceModel?.tokenAmountModel.tokenAliasModel,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupTokensList(BoxConstraints boxConstraints) {
    return ValueListenableBuilder<BalanceModel?>(
      valueListenable: selectedBalanceModelNotifier,
      builder: (_, BalanceModel? balanceModel, __) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          width: boxConstraints.maxWidth,
          height: ResponsiveWidget.isSmallScreen(context) ? 250 : 250,
          child: TokenDropdownList(
            initialTokenAliasModel: balanceModel?.tokenAmountModel.tokenAliasModel,
            onBalanceModelSelected: _handleBalanceModelChanged,
            walletAddress: widget.walletAddress,
          ),
        );
      },
    );
  }

  void _handleBalanceModelChanged(BalanceModel balanceModel) {
    popWrapperController.hideMenu();
    if (selectedBalanceModelNotifier.value != balanceModel) {
      selectedBalanceModelNotifier.value = balanceModel;
      BlocProvider.of<TokenFormCubit>(context).setBalanceModel(balanceModel);
    }
  }
}
