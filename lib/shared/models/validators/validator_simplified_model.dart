import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/validator_info.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class ValidatorSimplifiedModel extends Equatable {
  final WalletAddress walletAddress;
  final String? logo;
  final String? moniker;
  final WalletAddress? valkeyWalletAddress;
  final String? website;

  const ValidatorSimplifiedModel({
    required this.walletAddress,
    this.logo,
    this.moniker,
    this.valkeyWalletAddress,
    this.website,
  });

  factory ValidatorSimplifiedModel.fromDto(ValidatorInfo validatorInfo) {
    return ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32(validatorInfo.address),
      logo: validatorInfo.logo,
      moniker: validatorInfo.moniker,
      valkeyWalletAddress: validatorInfo.valkey == null ? null : WalletAddress.fromBech32(validatorInfo.valkey!),
      website: validatorInfo.website,
    );
  }

  @override
  List<Object?> get props => <Object?>[walletAddress, logo, moniker, valkeyWalletAddress];
}
