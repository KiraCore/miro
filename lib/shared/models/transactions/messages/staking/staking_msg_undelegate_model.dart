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
  final WalletAddress delegatorWalletAddress;
  final WalletAddress valoperWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgUndelegateModel({
    required this.delegatorWalletAddress,
    required this.valoperWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgUndelegate);

  StakingMsgUndelegateModel.single({
    required this.delegatorWalletAddress,
    required this.valoperWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgUndelegate);

  factory StakingMsgUndelegateModel.fromMsgDto(MsgUndelegate msgUndelegate) {
    return StakingMsgUndelegateModel(
      delegatorWalletAddress: WalletAddress.fromBech32(msgUndelegate.delegatorAddress),
      valoperWalletAddress: WalletAddress.fromBech32(msgUndelegate.valoperAddress),
      tokenAmountModels: msgUndelegate.amounts
          .map((Coin coin) => TokenAmountModel(
                lowestDenominationAmount: Decimal.parse(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgUndelegate(
      delegatorAddress: delegatorWalletAddress.bech32Address,
      valoperAddress: valoperWalletAddress.bech32Address,
      amounts: tokenAmountModels.map((TokenAmountModel tokenAmountModel) {
        return Coin(
          denom: tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInLowestDenomination().toString(),
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
    return valoperWalletAddress.bech32Address;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgUndelegate;
  }

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valoperWalletAddress, tokenAmountModels];
}
