import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/vote/msg_vote.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/shared/utils/enum_utils.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/rounded_icon.dart';

class MsgVotePreview extends StatelessWidget {
  final MsgVote message;
  final String memo;
  final TxFee fee;

  const MsgVotePreview({
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
          icon: KiraIdentityAvatar(address: message.voter, size: 45),
          prefix: 'Voter',
          child: Text(
            message.voter,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          icon: const RoundedIcon(
            size: 45,
            icon: Icon(
              Icons.how_to_vote,
            ),
          ),
          prefix: 'Option',
          child: Text(EnumUtils.parseToString(message.option)),
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          icon: const RoundedIcon(
            size: 45,
            icon: Icon(
              AppIcons.proposals,
            ),
          ),
          prefix: 'Proposal ID',
          child: Text(message.proposalId),
        ),
        const SizedBox(height: 20),
        const Divider(
          color: DesignColors.blue1_10,
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
