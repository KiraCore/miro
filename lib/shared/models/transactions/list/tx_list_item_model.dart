import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api/query_transactions/response/transaction.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';
import 'package:miro/shared/utils/enum_utils.dart';

class TxListItemModel extends AListItem with EquatableMixin {
  final String hash;
  final DateTime time;
  final TxDirectionType txDirectionType;
  final TxStatusType txStatusType;
  final List<ATxMsgModel> txMsgModels;
  final List<TokenAmountModel> fees;
  final List<PrefixedTokenAmountModel> prefixedTokenAmounts;

  bool _favourite = false;

  TxListItemModel({
    required this.hash,
    required this.time,
    required this.txDirectionType,
    required this.txStatusType,
    required this.fees,
    required this.prefixedTokenAmounts,
    required this.txMsgModels,
  });

  factory TxListItemModel.fromDto(Transaction transaction) {
    TxDirectionType txDirectionType = EnumUtils.parseFromString(TxDirectionType.values, transaction.direction);
    List<ATxMsgModel> txMsgModels = transaction.txs.map(ATxMsgModel.buildFromDto).toList();

    return TxListItemModel(
      hash: transaction.hash,
      time: CustomDateUtils.buildDateFromSecondsSinceEpoch(transaction.time),
      txDirectionType: txDirectionType,
      txStatusType: EnumUtils.parseFromString(TxStatusType.values, transaction.status),
      txMsgModels: txMsgModels,
      prefixedTokenAmounts: txMsgModels.expand((ATxMsgModel txMsgModel) => txMsgModel.getPrefixedTokenAmounts(txDirectionType)).toList(),
      fees: transaction.fee
          .map((Coin fee) => TokenAmountModel(lowestDenominationAmount: Decimal.parse(fee.amount), tokenAliasModel: TokenAliasModel.local(fee.denom)))
          .toList(),
    );
  }

  bool get isOutbound {
    return txDirectionType == TxDirectionType.outbound;
  }

  Widget get icon {
    if (txMsgModels.isEmpty) {
      return const Icon(Icons.error);
    } else if (isMultiTransaction) {
      return const Icon(Icons.more_horiz);
    } else {
      return txMsgModels.first.getIcon(txDirectionType);
    }
  }

  TxMsgType get txMsgType {
    if (txMsgModels.isEmpty) {
      return TxMsgType.undefined;
    } else if (isMultiTransaction) {
      return TxMsgType.multiple;
    } else {
      return txMsgModels.first.txMsgType;
    }
  }

  String getTitle(BuildContext context) {
    return isMultiTransaction ? S.of(context).txMsgMulti : txMsgModels.first.getTitle(context, txDirectionType);
  }

  String? getSubtitle(BuildContext context) {
    return isMultiTransaction ? null : txMsgModels.first.getSubtitle(txDirectionType);
  }

  bool get isMultiTransaction {
    return txMsgModels.length > 1;
  }

  @override
  String get cacheId => hash;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  List<Object?> get props => <Object>[hash, time, txDirectionType, txStatusType, txMsgModels, fees, prefixedTokenAmounts];
}
