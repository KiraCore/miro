import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_delete_records_form_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class IRMsgDeleteRecordsFormPreview extends StatefulWidget {
  final IRMsgDeleteRecordsFormModel irMsgDeleteRecordsFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  IRMsgDeleteRecordsFormPreview({
    required this.irMsgDeleteRecordsFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is IRMsgDeleteRecordsModel, 'ITxMsgModel must be an instance of IRMsgDeleteRecordsModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgDeleteRecordsFormPreview();
}

class _IRMsgDeleteRecordsFormPreview extends State<IRMsgDeleteRecordsFormPreview> {
  late final IRMsgDeleteRecordsModel irMsgDeleteRecordsModel = widget.txLocalInfoModel.txMsgModel as IRMsgDeleteRecordsModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: irMsgDeleteRecordsModel.walletAddress.address,
          icon: KiraIdentityAvatar(
            address: irMsgDeleteRecordsModel.walletAddress.address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        for (IRRecordModel irRecordModel in widget.irMsgDeleteRecordsFormModel.irRecordsModels!)
          Column(
            children: <Widget>[
              TxInputPreview(
                label: S.of(context).irTxHintKey,
                value: irRecordModel.key,
              ),
              const SizedBox(height: 28),
              TxInputPreview(
                label: S.of(context).irTxHintValue,
                value: irRecordModel.value ?? '',
              ),
              const SizedBox(height: 24),
              const Divider(color: DesignColors.grey2),
              const SizedBox(height: 24),
            ],
          ),
        Text(
          S.of(context).txNoticeFee(_feeAmountText),
          style: textTheme.bodySmall!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }
}
