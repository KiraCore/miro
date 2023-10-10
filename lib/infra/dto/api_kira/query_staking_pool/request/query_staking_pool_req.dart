import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class QueryStakingPoolReq extends Equatable {
  final WalletAddress? validatorWalletAddress;

  const QueryStakingPoolReq({
    this.validatorWalletAddress,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'validatorAddress': validatorWalletAddress?.bech32Address,
    };
  }

  @override
  List<Object?> get props => <Object?>[validatorWalletAddress];
}
