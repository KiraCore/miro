import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_delegate.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgDelegateModel extends ATxMsgModel {
  final WalletAddress delegatorWalletAddress;
  final WalletAddress valoperWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgDelegateModel({
    required this.delegatorWalletAddress,
    required this.valoperWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgDelegate);

  StakingMsgDelegateModel.single({
    required this.delegatorWalletAddress,
    required this.valoperWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgDelegate);

  factory StakingMsgDelegateModel.fromMsgDto(MsgDelegate msgDelegate) {
    return StakingMsgDelegateModel(
      delegatorWalletAddress: WalletAddress.fromBech32(msgDelegate.delegatorAddress),
      valoperWalletAddress: WalletAddress.fromBech32(msgDelegate.valoperAddress),
      tokenAmountModels: msgDelegate.amounts
          .map((Coin coin) => TokenAmountModel(
                lowestDenominationAmount: Decimal.parse(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgDelegate(
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
    return valoperWalletAddress.bech32Address;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).stakingTxDelegateTokens;
  }

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valoperWalletAddress, tokenAmountModels];
}
