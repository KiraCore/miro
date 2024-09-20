import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_delegate.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class StakingMsgDelegateModel extends ATxMsgModel {
  final String valkey;
  final AWalletAddress delegatorWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgDelegateModel({
    required this.valkey,
    required this.delegatorWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgDelegate);

  StakingMsgDelegateModel.single({
    required this.valkey,
    required this.delegatorWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgDelegate);

  factory StakingMsgDelegateModel.fromMsgDto(MsgDelegate msgDelegate) {
    return StakingMsgDelegateModel(
      valkey: msgDelegate.valoperAddress,
      delegatorWalletAddress: AWalletAddress.fromAddress(msgDelegate.delegatorAddress),
      tokenAmountModels: msgDelegate.amounts
          .map((CosmosCoin coin) => TokenAmountModel(
                defaultDenominationAmount: Decimal.fromBigInt(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgDelegate(
      delegatorAddress: delegatorWalletAddress.address,
      valoperAddress: valkey,
      amounts: tokenAmountModels.map((TokenAmountModel tokenAmountModel) {
        return CosmosCoin(
          denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInDefaultDenomination().toBigInt(),
        );
      }).toList(),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.attach_money);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return tokenAmountModels
        .map((TokenAmountModel e) => PrefixedTokenAmountModel(tokenAmountModel: e, tokenAmountPrefixType: TokenAmountPrefixType.subtract))
        .toList();
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return valkey;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgDelegate;
  }

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valkey, tokenAmountModels];
}
