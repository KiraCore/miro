import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';
import 'package:miro/views/widgets/transactions/transaction_status_chip/transaction_status_chip.dart';

class TransactionDetailsDrawerPage extends StatefulWidget {
  final TxListItemModel txListItemModel;

  const TransactionDetailsDrawerPage({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionDetailsDrawerPage();
}

class _TransactionDetailsDrawerPage extends State<TransactionDetailsDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          title: S.of(context).transactionDetailsDrawerTitle,
        ),
        const SizedBox(height: 32),
        _CommonDetails(txListItemModel: widget.txListItemModel),
        const SizedBox(height: 48),
        if (widget.txListItemModel.txMsgModels.isNotEmpty)
          Text(
            '${S.of(context).transactionDetailsDrawerMessages}:',
            style: textTheme.titleLarge!.copyWith(color: DesignColors.white1),
          ),
        for (final ATxMsgModel model in widget.txListItemModel.txMsgModels) ...<Widget>[
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          _Details(txMsgModel: model),
        ],
        const SizedBox(height: 48),
      ],
    );
  }
}

class _CommonDetails extends StatelessWidget {
  const _CommonDetails({required this.txListItemModel});

  final TxListItemModel txListItemModel;

  @override
  Widget build(BuildContext context) {
    Widget divider = const SizedBox(height: 12);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _CopyHoverTitleValue(title: S.of(context).txnListHash, value: txListItemModel.hash),
        divider,
        TransactionStatusChip(txStatusType: txListItemModel.txStatusType),
        divider,
        _Title(S.of(context).txListDate),
        const SizedBox(height: 4),
        _Value(DateFormat('d MMM y, HH:mm:ss').format(txListItemModel.time.toLocal())),
        divider,
        _Title(S.of(context).txnListFee),
        const SizedBox(height: 4),
        _Value(txListItemModel.fees.reduce((TokenAmountModel count, TokenAmountModel e) => count + e).toString()),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.txMsgModel});

  final ATxMsgModel txMsgModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Widget content;
    Widget divider = const SizedBox(height: 12);

    switch (txMsgModel) {
      case MsgSendModel():
        MsgSendModel model = txMsgModel as MsgSendModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).txListFrom, value: model.fromWalletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).txListTo, value: model.toWalletAddress.bech32Address),
            divider,
            _Title(S.of(context).txListAmount),
            const SizedBox(height: 4),
            _Value(model.tokenAmountModel.toString()),
          ],
        );
        break;
      case MsgUndefinedModel():
        content = const SizedBox.shrink();
        break;
      case IRMsgCancelVerificationRequestModel():
        IRMsgCancelVerificationRequestModel model = txMsgModel as IRMsgCancelVerificationRequestModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerWalletAddress, value: model.walletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerVerifyRequestId, value: model.verifyRequestId.toString()),
          ],
        );
        break;
      case IRMsgDeleteRecordsModel():
        IRMsgDeleteRecordsModel model = txMsgModel as IRMsgDeleteRecordsModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerWalletAddress, value: model.walletAddress.bech32Address),
            divider,
            _Title(S.of(context).transactionDetailsDrawerKeys),
            for (final String key in model.keys) ...<Widget>[
              const SizedBox(height: 4),
              _CopyHoverValue(value: key),
            ],
          ],
        );
        break;
      case IRMsgHandleVerificationRequestModel():
        IRMsgHandleVerificationRequestModel model = txMsgModel as IRMsgHandleVerificationRequestModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StatusChip(
              text: model.approvalStatusBool ? S.of(context).transactionDetailsDrawerApprovalStatusYes : S.of(context).transactionDetailsDrawerApprovalStatusNo,
              color: model.approvalStatusBool ? DesignColors.greenStatus1 : DesignColors.redStatus1,
            ),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerWalletAddress, value: model.walletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerVerifyRequestId, value: model.verifyRequestId.toString()),
          ],
        );
        break;
      case IRMsgRequestVerificationModel():
        IRMsgRequestVerificationModel model = txMsgModel as IRMsgRequestVerificationModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerWalletAddress, value: model.walletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerVerifierWalletAddress, value: model.verifierWalletAddress.bech32Address),
            divider,
            _Title(S.of(context).transactionDetailsDrawerTipAmount),
            const SizedBox(height: 4),
            _Value(model.tipTokenAmountModel.toString()),
            divider,
            _Title(S.of(context).transactionDetailsDrawerRecordIds),
            for (final int id in model.recordIds) ...<Widget>[
              const SizedBox(height: 4),
              _CopyHoverValue(value: id.toString()),
            ],
          ],
        );
        break;
      case IRMsgRegisterRecordsModel():
        IRMsgRegisterRecordsModel model = txMsgModel as IRMsgRegisterRecordsModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerWalletAddress, value: model.walletAddress.bech32Address),
            divider,
            _Title(S.of(context).transactionDetailsDrawerRecordIds),
            for (final IREntryModel entry in model.irEntryModels) ...<Widget>[
              const SizedBox(height: 6),
              _Title(S.of(context).transactionDetailsDrawerKey),
              const SizedBox(height: 2),
              _Value(entry.key),
              const SizedBox(height: 4),
              _Title(S.of(context).transactionDetailsDrawerValue),
              const SizedBox(height: 2),
              _Value(entry.info),
            ],
          ],
        );
        break;
      case StakingMsgClaimRewardsModel():
        StakingMsgClaimRewardsModel model = txMsgModel as StakingMsgClaimRewardsModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerSenderWalletAddress, value: model.senderWalletAddress.bech32Address),
          ],
        );
        break;
      case StakingMsgClaimUndelegationModel():
        StakingMsgClaimUndelegationModel model = txMsgModel as StakingMsgClaimUndelegationModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerSenderWalletAddress, value: model.senderWalletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerVerifyUndelegationId, value: model.undelegationId),
          ],
        );
        break;
      case StakingMsgDelegateModel():
        StakingMsgDelegateModel model = txMsgModel as StakingMsgDelegateModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerDelegatorWalletAddress, value: model.delegatorWalletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerValidatorKey, value: model.valkey),
            divider,
            _Title(S.of(context).transactionDetailsDrawerAmounts),
            for (final TokenAmountModel amount in model.tokenAmountModels) ...<Widget>[
              const SizedBox(height: 4),
              _Value(amount.toString()),
            ],
          ],
        );
        break;
      case StakingMsgUndelegateModel():
        StakingMsgUndelegateModel model = txMsgModel as StakingMsgUndelegateModel;
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerDelegatorWalletAddress, value: model.delegatorWalletAddress.bech32Address),
            divider,
            _CopyHoverTitleValue(title: S.of(context).transactionDetailsDrawerValidatorKey, value: model.valkey),
            divider,
            _Title(S.of(context).transactionDetailsDrawerAmounts),
            for (final TokenAmountModel amount in model.tokenAmountModels) ...<Widget>[
              const SizedBox(height: 4),
              _Value(amount.toString()),
            ],
          ],
        );
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // TODO(Mykyta): avoid direction type after INTERX updated to getAllTransactions
          txMsgModel.getTitle(context, TxDirectionType.outbound),
          maxLines: 3,
          style: textTheme.titleMedium!.copyWith(color: DesignColors.white2),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }
}

class _CopyHoverTitleValue extends StatelessWidget {
  const _CopyHoverTitleValue({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Title(title),
        const SizedBox(height: 4),
        _CopyHoverValue(value: value),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return Text('${title}:', style: headerStyle);
  }
}

class _Value extends StatelessWidget {
  const _Value(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle valueStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);

    return Text(value, overflow: TextOverflow.ellipsis, style: valueStyle);
  }
}

class _CopyHoverValue extends StatelessWidget {
  const _CopyHoverValue({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CopyButton(
          value: value,
          notificationText: S.of(context).toastSuccessfullyCopied,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: KiraToolTip(
            childMargin: EdgeInsets.zero,
            message: value,
            child: _Value(value),
          ),
        ),
      ],
    );
  }
}
