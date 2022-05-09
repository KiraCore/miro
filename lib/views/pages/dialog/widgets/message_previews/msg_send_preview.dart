import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/token_avatar.dart';

class MsgSendPreview extends StatelessWidget {
  final MsgSend message;
  final String memo;
  final TxFee fee;

  const MsgSendPreview({
    required this.message,
    required this.memo,
    required this.fee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PrefixedWidget(
          icon: KiraIdentityAvatar(address: message.fromAddress.bech32Address, size: 45),
          prefix: 'Send from',
          child: Text(
            message.fromAddress.bech32Address,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          icon: KiraIdentityAvatar(address: message.toAddress.bech32Address, size: 45),
          prefix: 'Send to',
          child: Text(
            message.toAddress.bech32Address,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          // TODO(dominik): Add token icon
          icon: const TokenAvatar(tokenIcon: '', size: 45),
          prefix: 'Amount',
          child: Text(
            message.amount.single.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(
          color: DesignColors.blue1_10,
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          prefix: 'Memo',
          child: Text(
            memo,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Transaction fee: ${fee.amount.single.toString()}',
          style: const TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
