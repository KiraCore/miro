import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/models/token_amount.dart';
import 'package:miro/views/pages/dialog/models/transaction_remote_info.dart';
import 'package:miro/views/pages/dialog/widgets/amount_input.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/message_form_type.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/transaction_form_controller.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class MsgSendForm extends StatefulWidget {
  final TransactionFormController controller;
  final MessageFormType formType;
  final TokenAlias? tokenAlias;
  final TransactionRemoteInfo transactionRemoteInfo;

  const MsgSendForm({
    required this.controller,
    required this.formType,
    required this.transactionRemoteInfo,
    this.tokenAlias,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendForm();
}

class _MsgSendForm extends State<MsgSendForm> {
  late final ValueNotifier<bool> _balancesLoading = ValueNotifier<bool>(false);
  List<Balance> _balancesList = List<Balance>.empty(growable: true);
  final TransactionsService transactionsService = globalLocator<TransactionsService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AmountInputController amountInputController = AmountInputController();
  final TextEditingController memoTextController = TextEditingController();
  final ValueNotifier<String> _senderAddress = ValueNotifier<String>('');
  final ValueNotifier<String> _recipientAddress = ValueNotifier<String>('');

  @override
  void initState() {
    if (widget.formType == MessageFormType.create) {
      Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
      _senderAddress.value = wallet.address.bech32Address;
      _updateBalances(wallet.address.bech32Address);
    }
    widget.controller.setUpController(
      validate: _validateForm,
      buildTransaction: _buildUnsignedTransaction,
    );
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
            disabled: widget.formType == MessageFormType.create,
            leading: ValueListenableBuilder<String>(
              valueListenable: _senderAddress,
              builder: (_, String value, __) {
                return KiraIdentityAvatar(
                  size: 45,
                  address: value,
                );
              },
            ),
            child: TextFormField(
              onChanged: (String value) {
                _onAddressChanged(_senderAddress, value);
                String? addressValid = _validateAddress(value);
                if (addressValid == null) {
                  _updateBalances(_senderAddress.value);
                } else {
                  _clearBalances();
                }
              },
              enabled: widget.formType != MessageFormType.create,
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
              builder: (_, String value, __) {
                return KiraIdentityAvatar(
                  size: 45,
                  address: value,
                );
              },
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
            builder: (_, bool loading, ___) {
              return AmountInput(
                loading: loading,
                disabled: _senderAddress.value.isEmpty || (!loading && _balancesList.isEmpty),
                address: _senderAddress.value,
                availableBalances: _balancesList,
                controller: amountInputController,
                initialTokenAlias: widget.tokenAlias,
                transactionRemoteInfo: widget.transactionRemoteInfo,
              );
            },
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

  Future<void> _updateBalances(String address) async {
    _balancesLoading.value = true;
    _clearBalances();
    try {
      QueryBalanceResp queryBalanceResp = await globalLocator<QueryBalanceService>().getAccountBalance(
        QueryBalanceReq(address: address),
      );
      _balancesList = queryBalanceResp.balances;
    } catch (_) {
      _balancesList = List<Balance>.empty(growable: true);
    }
    _balancesLoading.value = false;
  }

  void _clearBalances() {
    if (_balancesList.isNotEmpty) {
      setState(() {
        _balancesList.clear();
        if (amountInputController.reset != null) {
          amountInputController.reset!();
        }
      });
    }
  }

  void _onAddressChanged(ValueNotifier<String> valueNotifier, String value) {
    String? addressValid = _validateAddress(value);
    if (addressValid == null) {
      valueNotifier.value = value;
    } else {
      valueNotifier.value = '';
    }
    widget.controller.updateFormValidation();
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

  UnsignedTransaction _buildUnsignedTransaction() {
    assert(_validateForm(), 'Form should be valid before call this method');

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

  bool _validateForm() {
    bool amountValid = amountInputController.validate();
    bool senderValid = _validateAddress(_senderAddress.value) == null;
    bool recipientValid = _validateAddress(_recipientAddress.value) == null;
    return amountValid && senderValid && recipientValid;
  }

  TxFee _getTransactionFee() {
    Coin amount = Coin(
      value: BigInt.parse(widget.transactionRemoteInfo.queryNetworkPropertiesResp.properties.minTxFee),
      denom: 'ukex',
    );

    return TxFee(
      amount: <Coin>[
        amount,
      ],
    );
  }

  TxMsg _getMessage() {
    TokenAmount tokenAmount = amountInputController.save()!;

    return MsgSend(
      fromAddress: WalletAddress.fromBech32(_senderAddress.value),
      toAddress: WalletAddress.fromBech32(_recipientAddress.value),
      amount: <Coin>[
        Coin(
          value: BigInt.parse(tokenAmount.amount),
          denom: tokenAmount.denom,
        ),
      ],
    );
  }
}
