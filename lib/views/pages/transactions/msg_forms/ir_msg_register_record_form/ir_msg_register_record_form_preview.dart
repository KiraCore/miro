import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class IRMsgRegisterRecordFormPreview extends StatefulWidget {
  final TxLocalInfoModel txLocalInfoModel;

  IRMsgRegisterRecordFormPreview({
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is IRMsgRegisterRecordsModel, 'ITxMsgModel must be an instance of IRMsgRegisterRecordsModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgRegisterRecordFormPreview();
}

class _IRMsgRegisterRecordFormPreview extends State<IRMsgRegisterRecordFormPreview> {
  late final IRMsgRegisterRecordsModel iRMsgRegisterRecordsModel = widget.txLocalInfoModel.txMsgModel as IRMsgRegisterRecordsModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: iRMsgRegisterRecordsModel.walletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: iRMsgRegisterRecordsModel.walletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).irTxHintKey,
          value: iRMsgRegisterRecordsModel.irEntryModels.first.key,
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).irTxHintValue,
          value: iRMsgRegisterRecordsModel.irEntryModels.first.info,
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintMemo,
          value: widget.txLocalInfoModel.memo,
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        Text(
          S.of(context).txNoticeFee(_feeAmountText),
          style: textTheme.caption!.copyWith(
            color: DesignColors.white1,
          ),
        ),
      ],
    );
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }
}
