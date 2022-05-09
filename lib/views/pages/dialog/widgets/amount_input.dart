import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/token_utils.dart';
import 'package:miro/views/pages/dialog/models/token_amount.dart';
import 'package:miro/views/pages/dialog/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/models/transaction_remote_info.dart';
import 'package:miro/views/pages/dialog/widgets/tokens_dropdown.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';
import 'package:miro/views/widgets/kira/kira_chip.dart';

typedef AmountChangedCallback = TokenAmount? Function();

class AmountInputController {
  late AmountChangedCallback save;
  late bool Function() validate;
  void Function()? reset;

  void _setUpController({
    required AmountChangedCallback save,
    required bool Function() validate,
    required void Function() reset,
  }) {
    this.save = save;
    this.validate = validate;
    this.reset = reset;
  }
}

class AmountInput extends StatefulWidget {
  final AmountInputController controller;
  final TransactionRemoteInfo transactionRemoteInfo;
  final TokenAlias? initialTokenAlias;
  final List<Balance> availableBalances;
  final bool loading;
  final bool disabled;
  final String? address;

  const AmountInput({
    required this.controller,
    required this.transactionRemoteInfo,
    required this.availableBalances,
    required this.loading,
    required this.address,
    this.initialTokenAlias,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AmountInput();
}

class _AmountInput extends State<AmountInput> {
  final TokenDropdownController _tokenDropDownController = TokenDropdownController();
  final ValueNotifier<TokenAlias?> _selectedTokenAlias = ValueNotifier<TokenAlias?>(null);
  final TextEditingController _amountController = TextEditingController();
  TokenDenomination? _selectedTokenDenomination;
  String? _errorMessage;

  @override
  void initState() {
    widget.controller._setUpController(
      save: save,
      validate: validate,
      reset: reset,
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AmountInput oldWidget) {
    if (!widget.loading && widget.address != null && widget.address!.isNotEmpty && widget.availableBalances.isEmpty) {
      _errorMessage = 'No tokens available';
    }
    super.didUpdateWidget(oldWidget);
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
                child: _AmountTextField(
                  disabled: widget.disabled,
                  controller: _amountController,
                  onChanged: (_) => _validateTokenAmount(),
                  errorMessage: _errorMessage,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: DecoratedInput(
                  childHeight: 45,
                  child: TokensDropdown(
                    controller: _tokenDropDownController,
                    tokensDropdownType: TokensDropdownType.availableBalances,
                    balances: widget.availableBalances,
                    initialValue: widget.initialTokenAlias,
                    onTokenChanged: _onTokenChanged,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<TokenAlias?>(
            valueListenable: _selectedTokenAlias,
            builder: (_, __, ___) {
              return _NoteSection(
                loading: widget.loading,
                errorMessage: _errorMessage,
                maxTokenAmount: _getMaxSelectedTokenAmount(),
                tokenDenomination: _selectedTokenDenomination,
              );
            },
          ),
          const SizedBox(height: 14),
          if (_selectedTokenAlias.value != null)
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
                ValueListenableBuilder<TokenAlias?>(
                  valueListenable: _selectedTokenAlias,
                  builder: (_, TokenAlias? tokenAlias, __) {
                    if (tokenAlias == null) {
                      return const SizedBox();
                    }
                    return _DenominationChipsWrapper(
                      tokenAlias: tokenAlias,
                      onDenominationChanged: _onDenominationChanged,
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  TokenAmount? save() {
    if (_selectedTokenDenomination == null || _selectedTokenAlias.value == null) {
      return null;
    }
    final String currentAmount = _amountController.text;
    final String amountInLowestDenomination = TokenUtils.changeDenomination(
      amount: currentAmount,
      fromDenomination: _selectedTokenDenomination!.symbol,
      toDenomination: _selectedTokenAlias.value!.lowestDenomination,
      tokenAlias: _selectedTokenAlias.value!,
    );

    return TokenAmount(
      amount: amountInLowestDenomination,
      denom: _selectedTokenAlias.value!.lowestDenomination,
    );
  }

  bool validate() {
    bool paramsNotEmpty = _selectedTokenDenomination != null && _selectedTokenAlias.value != null;
    return paramsNotEmpty && _errorMessage == null;
  }

  void reset() {
    setState(() {
      _amountController.text = '';
      _selectedTokenDenomination = null;
      _selectedTokenAlias.value = null;
      _tokenDropDownController.reset();
    });
  }

  void _onTokenChanged(TokenAlias tokenAlias) {
    setState(() {
      _selectedTokenAlias.value = tokenAlias;
      _selectedTokenDenomination = TokenDenomination.fromTokenAlias(tokenAlias);
      _amountController.text = '';
    });
    _validateTokenAmount();
  }

  void _onDenominationChanged(TokenDenomination tokenDenomination) {
    if (_selectedTokenDenomination == null || _selectedTokenAlias.value == null) {
      return;
    }
    String newAmountValue = TokenUtils.changeDenomination(
      amount: _amountController.text,
      fromDenomination: _selectedTokenDenomination!.symbol,
      toDenomination: tokenDenomination.symbol,
      tokenAlias: _selectedTokenAlias.value!,
    );
    _selectedTokenDenomination = tokenDenomination;
    _amountController.text = newAmountValue;
    _validateTokenAmount();
  }

  void _validateTokenAmount() {
    double? maxTokenAmount = double.tryParse(_getMaxSelectedTokenAmount());
    double? currentAmount = double.tryParse(_amountController.text.isEmpty ? '0' : _amountController.text);

    if (maxTokenAmount == null || currentAmount == null) {
      _errorMessage = 'Cannot parse token amounts';
      AppLogger().log(
        message: 'Cannot parse tokens. [Max: $maxTokenAmount, Amount: $currentAmount]',
        logLevel: LogLevel.terribleFailure,
      );
      return;
    }

    int compareValue = maxTokenAmount.compareTo(currentAmount);
    if (compareValue == -1 && _errorMessage == null) {
      _setErrorMessage('Not enough tokens');
    } else if (compareValue != -1 && _errorMessage != null) {
      _setErrorMessage(null);
    }
  }

  String _getMaxSelectedTokenAmount() {
    if (widget.availableBalances.isEmpty ||
        widget.loading ||
        _selectedTokenDenomination == null ||
        _selectedTokenAlias.value == null) {
      return '0';
    }

    try {
      Balance selectedTokenAmount =
          widget.availableBalances.firstWhere((Balance e) => _selectedTokenAlias.value!.denoms.contains(e.denom));

      String maxTokenAmountValue = TokenUtils.changeDenomination(
        amount: selectedTokenAmount.amount,
        fromDenomination: selectedTokenAmount.denom,
        toDenomination: _selectedTokenDenomination!.symbol,
        tokenAlias: _selectedTokenAlias.value!,
      );
      return maxTokenAmountValue;
    } catch (_) {
      // Error is thrown if the token is not found in the list of available balances (user don't have it)
      // In this case, we return 0
      return '0';
    }
  }

  void _setErrorMessage(String? message) {
    setState(() {
      _errorMessage = message;
    });
  }
}

class _AmountTextField extends StatelessWidget {
  final void Function(String) onChanged;
  final TextEditingController controller;
  final String? errorMessage;
  final bool disabled;

  const _AmountTextField({
    required this.onChanged,
    required this.controller,
    required this.errorMessage,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedInput(
      childHeight: 45,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        enabled: !disabled,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
        decoration: InputDecoration(
          isDense: false,
          hintText: disabled ? '---' : '0',
          hintStyle: const TextStyle(
            color: DesignColors.white_100,
          ),
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
          floatingLabelStyle: const TextStyle(
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.only(bottom: 8),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: const Text(
            'Amount',
            style: TextStyle(color: DesignColors.gray2_100),
          ),
        ),
      ),
    );
  }
}

class _NoteSection extends StatelessWidget {
  final String maxTokenAmount;
  final TokenDenomination? tokenDenomination;
  final String? errorMessage;
  final bool loading;

  const _NoteSection({
    required this.maxTokenAmount,
    required this.loading,
    this.tokenDenomination,
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color messageColor = DesignColors.darkGreen;
    if (errorMessage != null) {
      messageColor = DesignColors.red_100;
    }

    if (loading) {
      return Row(
        children: const <Widget>[
          CenterLoadSpinner(size: 10),
          SizedBox(width: 8),
          Text(
            'Loading balances...',
            style: TextStyle(
              color: DesignColors.gray2_100,
              fontSize: 12,
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (tokenDenomination != null)
          Text(
            'Max value: ${maxTokenAmount} ${tokenDenomination!.symbol}',
            style: TextStyle(
              fontSize: 12,
              color: messageColor,
            ),
          ),
        if (tokenDenomination == null && errorMessage == null)
          const Text(
            'Enter the sender\'s address to select a token',
            style: TextStyle(
              color: DesignColors.gray2_100,
              fontSize: 12,
            ),
          ),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: TextStyle(
              fontSize: 12,
              color: messageColor,
            ),
          ),
      ],
    );
  }
}

class _DenominationChipsWrapper extends StatefulWidget {
  final TokenAlias tokenAlias;
  final void Function(TokenDenomination) onDenominationChanged;

  const _DenominationChipsWrapper({
    required this.tokenAlias,
    required this.onDenominationChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DenominationChipsWrapperState();
}

class _DenominationChipsWrapperState extends State<_DenominationChipsWrapper> {
  late TokenDenomination _selectedDenomination = _getMainDenomination();

  @override
  void didUpdateWidget(covariant _DenominationChipsWrapper oldWidget) {
    if (oldWidget.tokenAlias != widget.tokenAlias) {
      _selectedDenomination = _getMainDenomination();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _availableDenominations.map(_buildDenominationChips).toList(),
    );
  }

  List<TokenDenomination> get _availableDenominations {
    Set<TokenDenomination> availableDenominations = <TokenDenomination>{}
      ..add(TokenDenomination(symbol: widget.tokenAlias.symbol, decimals: widget.tokenAlias.decimals))
      ..add(_getMainDenomination());
    return availableDenominations.toList();
  }

  TokenDenomination _getMainDenomination() {
    return TokenDenomination(symbol: widget.tokenAlias.lowestDenomination, decimals: 0);
  }

  Widget _buildDenominationChips(TokenDenomination tokenDenomination) {
    return KiraChip(
      margin: const EdgeInsets.only(right: 8),
      selected: _selectedDenomination == tokenDenomination,
      label: tokenDenomination.symbol,
      onTap: () {
        widget.onDenominationChanged(tokenDenomination);
        setState(() {
          _selectedDenomination = tokenDenomination;
        });
      },
    );
  }
}
