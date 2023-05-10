import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkCustomSectionState extends Equatable {
  final bool isExpanded;
  final ANetworkStatusModel? checkedNetworkStatusModel;
  final ANetworkStatusModel? connectedNetworkStatusModel;

  factory NetworkCustomSectionState({
    ANetworkStatusModel? checkedNetworkStatusModel,
    ANetworkStatusModel? connectedNetworkStatusModel,
  }) {
    bool isExpanded = connectedNetworkStatusModel != null || checkedNetworkStatusModel != null;
    bool areNetworksEqual = connectedNetworkStatusModel?.uri.host == checkedNetworkStatusModel?.uri.host;

    if (isExpanded && areNetworksEqual) {
      return NetworkCustomSectionState._(
        isExpanded: isExpanded,
        connectedNetworkStatusModel: connectedNetworkStatusModel,
      );
    } else {
      return NetworkCustomSectionState._(
        isExpanded: isExpanded,
        checkedNetworkStatusModel: checkedNetworkStatusModel,
        connectedNetworkStatusModel: connectedNetworkStatusModel,
      );
    }
  }

  const NetworkCustomSectionState._({
    required this.isExpanded,
    this.checkedNetworkStatusModel,
    this.connectedNetworkStatusModel,
  });

  NetworkCustomSectionState copyWith({
    ANetworkStatusModel? checkedNetworkStatusModel,
    ANetworkStatusModel? connectedNetworkStatusModel,
  }) {
    return NetworkCustomSectionState(
      checkedNetworkStatusModel: checkedNetworkStatusModel ?? this.checkedNetworkStatusModel,
      connectedNetworkStatusModel: connectedNetworkStatusModel ?? this.connectedNetworkStatusModel,
    );
  }

  bool containsUri(Uri uri) {
    return  checkedNetworkStatusModel?.uri.host == uri.host || connectedNetworkStatusModel?.uri.host == uri.host;
  }

  Uri? get uri {
    return checkedNetworkStatusModel?.uri ?? connectedNetworkStatusModel?.uri;
  }

  @override
  List<Object?> get props => <Object?>[isExpanded, checkedNetworkStatusModel, connectedNetworkStatusModel];
}
