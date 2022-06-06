import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/views/pages/dialog/transactions/generic_transaction_page/sign_transaction_button.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_send_form.dart';

class GenericTransactionForm extends StatefulWidget {
  final String messageType;
  final Map<String, dynamic> metadata;
  final String feeValue;

  const GenericTransactionForm({
    required this.messageType,
    required this.metadata,
    required this.feeValue,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GenericTransactionForm();
}

class _GenericTransactionForm extends State<GenericTransactionForm> {
  final MsgFormController msgFormController = MsgFormController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildMessageForm(),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            SignTransactionButton(
              msgFormController: msgFormController,
              onPressed: _signTransaction,
            ),
            const Spacer(),
            Text(
              'Transaction fee: ${widget.feeValue} ukex',
              style: const TextStyle(color: DesignColors.gray2_100),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _signTransaction() async {
    // TODO(dominik): Add sign transaction functionality
  }

  Widget _buildMessageForm() {
    switch (widget.messageType) {
      case 'MsgSend':
        return MsgSendForm(
          msgFormController: msgFormController,
          msgFormType: MsgFormType.create,
          // TODO(dominik): Replace it to TokenType after refactor on balances list
          tokenAlias: widget.metadata['tokenAlias'] as TokenAlias?,
          feeValue: widget.feeValue,
        );
      default:
        return const Text('Unknown message type');
    }
  }
}
