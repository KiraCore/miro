import 'package:equatable/equatable.dart';

/// Contains information about a blockchain network
class WalletDetails extends Equatable {
  static const WalletDetails defaultWalletDetails = WalletDetails(bech32Hrp: 'kira', name: 'Kira Network');

  /// Bech32 human readable part
  final String bech32Hrp;

  /// Human readable chain name
  final String? name;

  /// Chain icon url
  final String? iconUrl;

  /// Default token name
  final String? defaultTokenName;

  /// Contains the information of a network.
  const WalletDetails({
    required this.bech32Hrp,
    this.name = '',
    this.iconUrl,
    this.defaultTokenName,
  });

  @override
  List<Object?> get props => <dynamic>[
        bech32Hrp,
        name,
        iconUrl,
        defaultTokenName,
      ];
}
