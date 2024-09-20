import 'dart:math';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class MsgSendModel extends ATxMsgModel {
  final AWalletAddress fromWalletAddress;
  final AWalletAddress toWalletAddress;
  final TokenAmountModel tokenAmountModel;

  const MsgSendModel({
    required this.fromWalletAddress,
    required this.toWalletAddress,
    required this.tokenAmountModel,
  }) : super(txMsgType: TxMsgType.msgSend);

  factory MsgSendModel.fromMsgDto(MsgSend msgSend) {
    return MsgSendModel(
      fromWalletAddress: AWalletAddress.fromAddress(msgSend.fromAddress),
      toWalletAddress: AWalletAddress.fromAddress(msgSend.toAddress),
      tokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.fromBigInt(msgSend.amount.first.amount),
        tokenAliasModel: TokenAliasModel.local(msgSend.amount.first.denom),
      ),
    );
  }

  @override
  MsgSend toMsgDto() {
    return MsgSend(
      fromAddress: fromWalletAddress.address,
      toAddress: toWalletAddress.address,
      amount: <CosmosCoin>[
        CosmosCoin(
          denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInDefaultDenomination().toBigInt(),
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
      return toWalletAddress.address;
    } else {
      return fromWalletAddress.address;
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
