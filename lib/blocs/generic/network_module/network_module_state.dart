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

  NetworkModuleState.refreshing(ANetworkStatusModel networkStatusModel)
      : networkStatusModel = networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.refreshing, lastRefreshDateTime: DateTime.now());

  bool get isConnecting => networkStatusModel.connectionStatusType == ConnectionStatusType.connecting;

  bool get isConnected =>
      networkStatusModel.connectionStatusType == ConnectionStatusType.connected || networkStatusModel.connectionStatusType == ConnectionStatusType.refreshing;

  bool get isDisconnected => networkStatusModel.connectionStatusType == ConnectionStatusType.disconnected;

  bool get isRefreshing => networkStatusModel.connectionStatusType == ConnectionStatusType.refreshing;

  bool get valuesFromNetworkExistBool => networkStatusModel.tokenDefaultDenomModel.valuesFromNetworkExistBool;

  String? get bech32AddressPrefix => networkStatusModel.tokenDefaultDenomModel.bech32AddressPrefix;

  TokenAliasModel? get defaultTokenAliasModel => networkStatusModel.tokenDefaultDenomModel.defaultTokenAliasModel;

  Uri get networkUri => networkStatusModel.uri;

  @override
  List<Object?> get props => <Object?>[networkStatusModel];
}
