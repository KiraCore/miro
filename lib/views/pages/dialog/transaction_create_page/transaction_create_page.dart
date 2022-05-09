import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/query_network_properties_resp.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/pages/dialog/models/transaction_remote_info.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/message_form_type.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/msg_send_form.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/transaction_form_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TransactionCreatePage extends StatefulWidget {
  final String messageType;
  final Map<String, dynamic>? metadata;

  const TransactionCreatePage({
    @QueryParam('messageType') this.messageType = 'MsgSend',
    @QueryParam('metadata') this.metadata,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionCreatePage();
}

class _TransactionCreatePage extends State<TransactionCreatePage> {
  TransactionFormController transactionFormController = TransactionFormController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        title: _getFormTitle(),
        child: FutureBuilder<TransactionRemoteInfo>(
          future: _fetchTransactionRemoteInfo(),
          builder: (BuildContext context, AsyncSnapshot<TransactionRemoteInfo> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: CenterLoadSpinner(),
              );
            }

            return Column(
              children: <Widget>[
                _getForm(snapshot.data!),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    _SignTransactionButton(
                      transactionFormController: transactionFormController,
                      onPressed: _sendTransaction,
                    ),
                    const Spacer(),
                    Text(
                      'Transaction fee: ${snapshot.data!.queryNetworkPropertiesResp.properties.minTxFee} ukex',
                      style: const TextStyle(color: DesignColors.gray2_100),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<TransactionRemoteInfo> _fetchTransactionRemoteInfo() async {
    TransactionRemoteInfo transactionRemoteInfo = TransactionRemoteInfo(
      queryNetworkPropertiesResp: QueryNetworkPropertiesResp.mock(),
    );
    return transactionRemoteInfo;
  }

  String _getFormTitle() {
    Map<String, String> pageTitles = <String, String>{
      'MsgSend': 'Send tokens',
    };
    return pageTitles[widget.messageType] ?? 'Unknown transaction';
  }

  Widget _getForm(TransactionRemoteInfo transactionRemoteInfo) {
    switch (widget.messageType) {
      case 'MsgSend':
        return MsgSendForm(
          controller: transactionFormController,
          formType: MessageFormType.create,
          tokenAlias: widget.metadata?['tokenAlias'] as TokenAlias?,
          transactionRemoteInfo: transactionRemoteInfo,
        );
      default:
        return const SizedBox();
    }
  }

  Future<void> _sendTransaction() async {
    bool formValid = transactionFormController.validate();
    if (!formValid) {
      return;
    }
    Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
    UnsignedTransaction unsignedTransaction = transactionFormController.buildTransaction();
    if (wallet is SaifuWallet) {
      await _signSaifuTransaction(unsignedTransaction);
    } else {
      await _signUnsafeTransaction(unsignedTransaction);
    }
  }

  Future<void> _signSaifuTransaction(UnsignedTransaction unsignedTransaction) async {
    await AutoRouter.of(context).push(
      TransactionSignWithSaifuRoute(unsignedTransaction: unsignedTransaction),
    );
  }

  Future<void> _signUnsafeTransaction(UnsignedTransaction unsignedTransaction) async {
    try {
      SignedTransaction signedTransaction =
          await globalLocator<TransactionsService>().signTransaction(unsignedTransaction);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await AutoRouter.of(context).navigate(
        TransactionConfirmRoute(signedTransaction: signedTransaction),
      );
    } catch (e) {
      AppLogger().log(message: 'Something went wrong while signing transaction: $e');
    }
  }
}

class _SignTransactionButton extends StatefulWidget {
  final TransactionFormController transactionFormController;
  final Future<void> Function() onPressed;

  const _SignTransactionButton({
    required this.transactionFormController,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignTransactionButtonState();
}

class _SignTransactionButtonState extends State<_SignTransactionButton> {
  bool loading = false;
  bool valid = false;

  @override
  void initState() {
    widget.transactionFormController.addListener(() {
      if (mounted && widget.transactionFormController.valid != valid) {
        setState(() {
          valid = widget.transactionFormController.valid;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(
        height: 51,
        child: Center(
          child: Text('Signing transaction...'),
        ),
      );
    }
    return KiraElevatedButton(
      width: 82,
      height: 51,
      disabled: !valid,
      onPressed: () => _onSignTransactionButtonPressed(context),
      title: 'Next',
    );
  }

  Future<void> _onSignTransactionButtonPressed(BuildContext context) async {
    _setLoadingStatus(status: true);
    await widget.onPressed();
    _setLoadingStatus(status: false);
  }

  void _setLoadingStatus({required bool status}) {
    setState(() {
      loading = status;
    });
  }
}
