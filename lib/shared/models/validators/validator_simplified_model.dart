import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class ValidatorSimplifiedModel extends Equatable {
  final WalletAddress walletAddress;
  final WalletAddress valkeyWalletAddress;
  final String? logo;
  final String? moniker;

  const ValidatorSimplifiedModel({
    required this.walletAddress,
    required this.valkeyWalletAddress,
    this.logo,
    this.moniker,
  });

  @override
  List<Object?> get props => <Object?>[walletAddress, valkeyWalletAddress, logo, moniker];
}
