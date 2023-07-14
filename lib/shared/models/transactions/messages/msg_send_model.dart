import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgSendModel extends ATxMsgModel {
  final WalletAddress fromWalletAddress;
  final WalletAddress toWalletAddress;
  final TokenAmountModel tokenAmountModel;

  const MsgSendModel({
    required this.fromWalletAddress,
    required this.toWalletAddress,
    required this.tokenAmountModel,
  }) : super(txMsgType: TxMsgType.msgSend);

  factory MsgSendModel.fromMsgDto(MsgSend msgSend) {
    return MsgSendModel(
      fromWalletAddress: WalletAddress.fromBech32(msgSend.fromAddress),
      toWalletAddress: WalletAddress.fromBech32(msgSend.toAddress),
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.parse(msgSend.amount.first.amount),
        tokenAliasModel: TokenAliasModel.local(msgSend.amount.first.denom),
      ),
    );
  }

  @override
  MsgSend toMsgDto() {
    return MsgSend(
      fromAddress: fromWalletAddress.bech32Address,
      toAddress: toWalletAddress.bech32Address,
      amount: <Coin>[
        Coin(
          denom: tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInLowestDenomination().toString(),
        ),
      ],
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return Transform.rotate(
        angle: -pi / 2,
        child: const Icon(AppIcons.arrow_up_right),
      );
    } else {
      return Transform.rotate(
        angle: pi / 2,
        child: const Icon(AppIcons.arrow_up_right),
      );
    }
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[
      PrefixedTokenAmountModel(
        tokenAmountModel: tokenAmountModel,
        tokenAmountPrefixType: txDirectionType == TxDirectionType.outbound ? TokenAmountPrefixType.subtract : TokenAmountPrefixType.add,
      ),
    ];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return toWalletAddress.bech32Address;
    } else {
      return fromWalletAddress.bech32Address;
    }
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return S.of(context).txMsgSendSendTokens;
    } else {
      return S.of(context).txMsgSendReceiveTokens;
    }
  }

  @override
  List<Object?> get props => <Object>[fromWalletAddress, toWalletAddress, tokenAmountModel];
}
