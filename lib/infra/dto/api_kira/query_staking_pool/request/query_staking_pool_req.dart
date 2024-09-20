import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class QueryStakingPoolReq extends Equatable {
  final AWalletAddress? validatorWalletAddress;

  const QueryStakingPoolReq({
    this.validatorWalletAddress,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'validatorAddress': validatorWalletAddress?.address,
    };
  }

  @override
  List<Object?> get props => <Object?>[validatorWalletAddress];
}
