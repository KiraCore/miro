import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_undelegate.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgUndelegateModel extends ATxMsgModel {
  final String valkey;
  final WalletAddress delegatorWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgUndelegateModel({
    required this.valkey,
    required this.delegatorWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgUndelegate);

  StakingMsgUndelegateModel.single({
    required this.valkey,
    required this.delegatorWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgUndelegate);

  factory StakingMsgUndelegateModel.fromMsgDto(MsgUndelegate msgUndelegate) {
    return StakingMsgUndelegateModel(
      valkey: msgUndelegate.valoperAddress,
      delegatorWalletAddress: WalletAddress.fromBech32(msgUndelegate.delegatorAddress),
      tokenAmountModels: msgUndelegate.amounts
          .map((Coin coin) => TokenAmountModel(
                defaultDenominationAmount: Decimal.parse(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgUndelegate(
      delegatorAddress: delegatorWalletAddress.bech32Address,
      valoperAddress: valkey,
      amounts: tokenAmountModels.map((TokenAmountModel tokenAmountModel) {
        return Coin(
          denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInDefaultDenomination().toString(),
        );
      }).toList(),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.money_off);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return tokenAmountModels
        .map((TokenAmountModel e) => PrefixedTokenAmountModel(tokenAmountModel: e, tokenAmountPrefixType: TokenAmountPrefixType.add))
        .toList();
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return valkey;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgUndelegate;
  }

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valkey, tokenAmountModels];
}
