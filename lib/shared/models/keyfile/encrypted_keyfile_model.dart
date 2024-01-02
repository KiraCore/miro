import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class EncryptedKeyfileModel extends Equatable {
  final String version;
  final String secretDataHash;
  final WalletAddress walletAddress;

  const EncryptedKeyfileModel({
    required this.version,
    required this.secretDataHash,
    required this.walletAddress,
  });

  @override
  List<Object?> get props => <Object>[version, secretDataHash, walletAddress];
}
