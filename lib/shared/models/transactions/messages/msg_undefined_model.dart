import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/msg_undefined.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class MsgUndefinedModel extends ATxMsgModel {
  const MsgUndefinedModel() : super(txMsgType: TxMsgType.undefined);

  @override
  MsgUndefined toMsgDto() {
    return const MsgUndefined();
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.error);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return null;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgUndefined;
  }

  @override
  List<Object?> get props => <Object>[];
}
