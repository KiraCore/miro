import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_button.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';

class TokenDropdown extends StatefulWidget {
  final bool disabledBool;
  final BalanceModel? defaultBalanceModel;
  final WalletAddress? walletAddress;

  const TokenDropdown({
    this.disabledBool = false,
    this.defaultBalanceModel,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenDropdown();
}

class _TokenDropdown extends State<TokenDropdown> {
  late final ValueNotifier<BalanceModel?> selectedBalanceModelNotifier = ValueNotifier<BalanceModel?>(widget.defaultBalanceModel);
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return PopWrapper(
          disabled: widget.disabledBool,
          popWrapperController: popWrapperController,
          buttonBuilder: () => _buildSelectedTokenButton(boxConstraints),
          popupBuilder: () => _buildPopupTokensList(boxConstraints),
        );
      },
    );
  }

  Widget _buildSelectedTokenButton(BoxConstraints boxConstraints) {
    return ValueListenableBuilder<BalanceModel?>(
      valueListenable: selectedBalanceModelNotifier,
      builder: (_, BalanceModel? balanceModel, __) {
        return TxInputWrapper(
          height: 80,
          disabled: widget.disabledBool,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: TokenDropdownButton(tokenAliasModel: balanceModel?.tokenAmountModel.tokenAliasModel),
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
          padding: const EdgeInsets.all(8),
          width: boxConstraints.maxWidth,
          height: const ResponsiveValue<double?>(
            largeScreen: 250,
            mediumScreen: 250,
            smallScreen: null,
          ).get(context),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
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
    popWrapperController.hideTooltip();
    if (selectedBalanceModelNotifier.value != balanceModel) {
      selectedBalanceModelNotifier.value = balanceModel;
      BlocProvider.of<TokenFormCubit>(context).updateBalance(balanceModel);
    }
  }
}
