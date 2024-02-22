import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_empty_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class NetworkModuleState extends Equatable {
  final ANetworkStatusModel networkStatusModel; // NetworkEmptyModel

  NetworkModuleState.connecting(ANetworkStatusModel networkStatusModel)
      : networkStatusModel = networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.connecting);

  NetworkModuleState.connected(ANetworkStatusModel networkStatusModel)
      : networkStatusModel = networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.connected);

  NetworkModuleState.disconnected() : networkStatusModel = NetworkEmptyModel(connectionStatusType: ConnectionStatusType.disconnected);

  bool get isConnecting => networkStatusModel.connectionStatusType == ConnectionStatusType.connecting;

  bool get isConnected => networkStatusModel.connectionStatusType == ConnectionStatusType.connected;

  bool get isDisconnected => networkStatusModel.connectionStatusType == ConnectionStatusType.disconnected;

  Uri get networkUri => networkStatusModel.uri;

  String get defaultBech32Prefix {
    String? defaultAddressPrefix = networkStatusModel.tokenDefaultDenomModel?.publicAddressPrefix;
    if (defaultAddressPrefix == null) {
      throw StateError('Network is not connected or does not have required info, hence no default address prefix is available');
    }
    return defaultAddressPrefix;
  }

  TokenAliasModel get defaultTokenAliasModel {
    TokenAliasModel? defaultTokenAliasModel = networkStatusModel.tokenDefaultDenomModel?.defaultTokenAliasModel;
    if (defaultTokenAliasModel == null) {
      throw StateError('Network is not connected or does not have required info, hence no default token is available');
    }
    return defaultTokenAliasModel;
  }

  @override
  List<Object?> get props => <Object?>[networkStatusModel];
}
