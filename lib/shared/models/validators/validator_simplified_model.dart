import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class ValidatorSimplifiedModel extends Equatable {
  final AWalletAddress walletAddress;
  final String? logo;
  final String? moniker;
  final String? valkey;
  final String? website;

  const ValidatorSimplifiedModel({
    required this.walletAddress,
    this.logo,
    this.moniker,
    this.valkey,
    this.website,
  });

  @override
  List<Object?> get props => <Object?>[walletAddress, logo, moniker, valkey, website];
}
