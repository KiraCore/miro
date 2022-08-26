import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/views/pages/transactions/send/msg_send_form.dart';
import 'package:miro/views/pages/transactions/send/msg_send_form_controller.dart';
import 'package:miro/views/widgets/transactions/tx_create_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class MsgSendCreatePage extends StatefulWidget {
  final BalanceModel? initialBalanceModel;

  const MsgSendCreatePage({
    this.initialBalanceModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendCreatePage();
}

class _MsgSendCreatePage extends State<MsgSendCreatePage> {
  final WalletProvider walletProvider = globalLocator<WalletProvider>();
  final MsgSendFormController msgSendFormController = MsgSendFormController();

  // TODO(dominik): Mocked value
  final TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: 'Send tokens',
      child: Column(
        children: <Widget>[
          MsgSendForm(
            feeTokenAmountModel: feeTokenAmountModel,
            msgSendFormController: msgSendFormController,
            initialBalanceModel: widget.initialBalanceModel,
            initialWalletAddress: walletProvider.currentWallet?.address,
          ),
          const SizedBox(height: 30),
          TxCreateFooter(
            feeTokenAmountModel: feeTokenAmountModel,
            txMsgFormController: msgSendFormController,
          ),
        ],
      ),
    );
  }
}
