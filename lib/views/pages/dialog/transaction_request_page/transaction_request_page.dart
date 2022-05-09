import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/query_network_properties_resp.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/dialog/models/transaction_remote_info.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/message_form_type.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/msg_send_form.dart';
import 'package:miro/views/pages/dialog/widgets/message_forms/transaction_form_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TransactionRequestPage extends StatefulWidget {
  final String messageType;

  const TransactionRequestPage({
    @QueryParam('messageType') this.messageType = 'MsgSend',
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionRequestPage();
}

class _TransactionRequestPage extends State<TransactionRequestPage> {
  TransactionFormController transactionFormController = TransactionFormController();
  ValueNotifier<bool> formValid = ValueNotifier<bool>(false);
  bool loading = false;

  @override
  void initState() {
    transactionFormController.addListener(() {
      if (mounted && transactionFormController.valid != formValid.value) {
        formValid.value = transactionFormController.valid;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        title: _getRequestTitle(),
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
                _getRequestForm(snapshot.data!),
                const SizedBox(height: 14),
                _RequestFormFooter(
                  onNextPressed: _onNextPressed,
                  transactionRemoteInfo: snapshot.data!,
                  formValid: formValid,
                  transactionFormController: transactionFormController,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getRequestTitle() {
    Map<String, String> pageTitles = <String, String>{
      'MsgSend': 'Request token',
    };
    return pageTitles[widget.messageType] ?? 'Unknown transaction request';
  }

  Widget _getRequestForm(TransactionRemoteInfo transactionRemoteInfo) {
    switch (widget.messageType) {
      case 'MsgSend':
        return MsgSendForm(
          controller: transactionFormController,
          formType: MessageFormType.request,
          transactionRemoteInfo: transactionRemoteInfo,
        );
      default:
        return const SizedBox();
    }
  }

  Future<TransactionRemoteInfo> _fetchTransactionRemoteInfo() async {
    TransactionRemoteInfo transactionRemoteInfo = TransactionRemoteInfo(
      queryNetworkPropertiesResp: QueryNetworkPropertiesResp.mock(),
    );
    return transactionRemoteInfo;
  }

  void _onNextPressed() {
    UnsignedTransaction unsignedTransaction = transactionFormController.buildTransaction();
    AutoRouter.of(context).navigate(TransactionRequestResultRoute(unsignedTransaction: unsignedTransaction));
  }
}

class _RequestFormFooter extends StatelessWidget {
  final TransactionFormController transactionFormController;
  final TransactionRemoteInfo transactionRemoteInfo;
  final ValueListenable<bool> formValid;
  final void Function() onNextPressed;

  const _RequestFormFooter({
    required this.transactionRemoteInfo,
    required this.transactionFormController,
    required this.formValid,
    required this.onNextPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ValueListenableBuilder<bool>(
          valueListenable: formValid,
          builder: (_, bool valid, __) {
            return KiraElevatedButton(
              width: 82,
              height: 51,
              disabled: !valid,
              onPressed: onNextPressed,
              title: 'Next',
            );
          },
        ),
        const Spacer(),
        Text(
          'Transaction fee: ${transactionRemoteInfo.queryNetworkPropertiesResp.properties.minTxFee} ukex',
          style: const TextStyle(
            color: DesignColors.gray2_100,
          ),
        ),
      ],
    );
  }
}
