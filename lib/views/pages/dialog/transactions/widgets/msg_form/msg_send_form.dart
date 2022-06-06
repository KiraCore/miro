import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_amount.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_controller.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class MsgSendForm extends StatefulWidget {
  final MsgFormController msgFormController;
  final MsgFormType msgFormType;
  final String feeValue;
  final TokenAlias? tokenAlias;

  const MsgSendForm({
    required this.msgFormController,
    required this.msgFormType,
    required this.feeValue,
    this.tokenAlias,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendForm();
}

class _MsgSendForm extends State<MsgSendForm> {
  late TokenSectionController tokenSectionController = TokenSectionController(availableBalances: <Balance>[]);
  late final ValueNotifier<bool> _balancesLoading = ValueNotifier<bool>(false);
  List<Balance> _balancesList = List<Balance>.empty(growable: true);
  final TransactionsService transactionsService = globalLocator<TransactionsService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController memoTextController = TextEditingController();
  final ValueNotifier<String> _senderAddress = ValueNotifier<String>('');
  final ValueNotifier<String> _recipientAddress = ValueNotifier<String>('');

  @override
  void initState() {
    if (widget.msgFormType == MsgFormType.create) {
      Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
      _senderAddress.value = wallet.address.bech32Address;
      _updateBalancesForAddress(wallet.address.bech32Address);
    }
    widget.msgFormController.setUpController(
      buildTransaction: _buildUnsignedTransaction,
    );
    _validate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DecoratedInput(
            disabled: widget.msgFormType == MsgFormType.create,
            leading: ValueListenableBuilder<String>(
              valueListenable: _senderAddress,
              builder: _buildKiraIdentityAvatar,
            ),
            child: TextFormField(
              onChanged: _onSenderAddressChanged,
              enabled: widget.msgFormType != MsgFormType.create,
              initialValue: _senderAddress.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateAddress,
              decoration: const InputDecoration(
                label: Text(
                  'Send from',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          DecoratedInput(
            leading: ValueListenableBuilder<String>(
              valueListenable: _recipientAddress,
              builder: _buildKiraIdentityAvatar,
            ),
            child: TextFormField(
              onChanged: (String value) => _onAddressChanged(_recipientAddress, value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateAddress,
              decoration: const InputDecoration(
                label: Text(
                  'Send to',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<bool>(
            valueListenable: _balancesLoading,
            builder: _buildTokenSection,
          ),
          const SizedBox(height: 14),
          DecoratedInput(
            child: TextFormField(
              controller: memoTextController,
              maxLength: 200,
              decoration: const InputDecoration(
                label: Text(
                  'Memo',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKiraIdentityAvatar(BuildContext context, String value, Widget? child) {
    return KiraIdentityAvatar(
      size: 45,
      address: value,
    );
  }

  void _onSenderAddressChanged(String address) {
    _onAddressChanged(_senderAddress, address);
    String? addressValid = _validateAddress(address);
    if (addressValid == null) {
      _updateBalancesForAddress(_senderAddress.value);
    }
  }

  void _onAddressChanged(ValueNotifier<String> valueNotifier, String address) {
    String? addressValid = _validateAddress(address);
    if (addressValid == null) {
      valueNotifier.value = address;
    } else {
      valueNotifier.value = '';
    }
    _validate();
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    try {
      WalletAddress.fromBech32(value);
      return null;
    } catch (e) {
      return 'Invalid address';
    }
  }

  Future<void> _updateBalancesForAddress(String address) async {
    _balancesLoading.value = true;
    _balancesList.clear();
    try {
      _balancesList = _fetchAvailableBalancesForAddress(address);
      tokenSectionController = TokenSectionController(
        availableBalances: _balancesList,
        walletAddress: WalletAddress.fromBech32(address),
      );
    } catch (_) {
      tokenSectionController.setErrorMessage('Cannot get available balances. Check your internet connection');
    }
    _balancesLoading.value = false;
  }

  List<Balance> _fetchAvailableBalancesForAddress(String address) {
    // TODO(dominik): Mocked values
    return const <Balance>[
      Balance(amount: '10000', denom: 'ukex'),
      Balance(amount: '100000000', denom: 'ETH'),
      Balance(amount: '123', denom: 'BTC'),
      Balance(amount: '0.2', denom: 'LUNA'),
      Balance(amount: '25555555555', denom: 'LUNC'),
      Balance(amount: '786', denom: 'SHIB'),
      Balance(amount: '101', denom: 'EUR'),
      Balance(amount: '3000', denom: 'USDT'),
    ];
  }

  Widget _buildTokenSection(BuildContext context, bool loading, Widget? child) {
    return TokenSection(
      loading: loading,
      disabled: _senderAddress.value.isEmpty || (!loading && _balancesList.isEmpty),
      address: _senderAddress.value,
      availableBalances: _balancesList,
      tokenSectionController: tokenSectionController,
      initialTokenType: widget.tokenAlias != null ? TokenType.fromTokenAlias(widget.tokenAlias!) : null,
      msgFormType: widget.msgFormType,
      onUpdateValidation: _validate,
    );
  }

  String? _validate() {
    String? errorMessage = _getErrorMessage();
    widget.msgFormController.setErrorMessage(errorMessage: errorMessage);
    return errorMessage;
  }

  String? _getErrorMessage() {
    String? amountErrorMessage = tokenSectionController.validate();
    String? senderAddressErrorMessage = _validateAddress(_senderAddress.value);
    String? recipientAddressErrorMessage = _validateAddress(_recipientAddress.value);
    return amountErrorMessage ?? senderAddressErrorMessage ?? recipientAddressErrorMessage;
  }

  UnsignedTransaction _buildUnsignedTransaction() {
    assert(_validate() == null, 'Form should be valid before call this method');

    String memo = memoTextController.text;
    if (memo.isEmpty) {
      memo = 'MsgSend to ${_recipientAddress.value}';
    }
    TxFee transactionFee = _getTransactionFee();
    TxMsg message = _getMessage();

    UnsignedTransaction unsignedTransaction = UnsignedTransaction(
      fee: transactionFee,
      memo: memo,
      messages: <TxMsg>[
        message,
      ],
    );
    return unsignedTransaction;
  }

  TxFee _getTransactionFee() {
    Coin amount = Coin(
      value: BigInt.parse(widget.feeValue),
      denom: 'ukex',
    );

    return TxFee(
      amount: <Coin>[
        amount,
      ],
    );
  }

  TxMsg _getMessage() {
    TokenAmount tokenAmount = tokenSectionController.save()!;
    TokenDenomination lowestTokenDenomination = tokenSectionController.selectedTokenType!.lowestTokenDenomination;
    BigInt lowestTokenAmount = tokenAmount.calculateAmountAsDenomination(lowestTokenDenomination).toBigInt();
    return MsgSend(
      fromAddress: WalletAddress.fromBech32(_senderAddress.value),
      toAddress: WalletAddress.fromBech32(_recipientAddress.value),
      amount: <Coin>[
        Coin(
          value: lowestTokenAmount,
          denom: lowestTokenDenomination.name,
        ),
      ],
    );
  }
}
