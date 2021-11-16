import 'package:equatable/equatable.dart';

/// Contains information about a blockchain network
class WalletDetails extends Equatable {
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

  factory WalletDetails.fromJson(Map<String, dynamic> json) {
    return WalletDetails(
      bech32Hrp: json['bech32Hrp'] as String,
      name: json['name'] as String?,
      iconUrl: json['iconUrl'] as String?,
      defaultTokenName: json['defaultTokenName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'bech32Hrp': bech32Hrp,
        'name': name,
        'iconUrl': iconUrl,
        'defaultTokenName': defaultTokenName,
      };
}
