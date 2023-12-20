import 'package:equatable/equatable.dart';

class GenesisResp extends Equatable {
  final String defaultDenom;
  final String bech32Prefix;

  const GenesisResp({
    required this.defaultDenom,
    required this.bech32Prefix,
  });

  factory GenesisResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> appStateJson = json['app_state'] as Map<String, dynamic>;
    Map<String, dynamic> customGovJson = appStateJson['customgov'] as Map<String, dynamic>;
    return GenesisResp(
      // TODO(Marcin): delete null conditions after this parameter is implemented on chaosnet/mainnet
      defaultDenom: customGovJson['default_denom'] as String? ?? 'ukex',
      bech32Prefix: customGovJson['bech32_prefix'] as String? ?? 'kira',
    );
  }

  @override
  List<Object?> get props => <Object>[defaultDenom, bech32Prefix];
}
