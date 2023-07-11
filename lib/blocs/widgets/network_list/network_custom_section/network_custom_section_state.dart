import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkCustomSectionState extends Equatable {
  final bool expandedBool;
  final ANetworkStatusModel? checkedNetworkStatusModel;
  final ANetworkStatusModel? connectedNetworkStatusModel;
  final ANetworkStatusModel? lastConnectedNetworkStatusModel;

  factory NetworkCustomSectionState({
    bool? expandedBool,
    ANetworkStatusModel? checkedNetworkStatusModel,
    ANetworkStatusModel? connectedNetworkStatusModel,
    ANetworkStatusModel? lastConnectedNetworkStatusModel,
  }) {
    bool customSectionNotEmptyBool = checkedNetworkStatusModel != null || connectedNetworkStatusModel != null || lastConnectedNetworkStatusModel != null;

    return NetworkCustomSectionState._(
      expandedBool: expandedBool ?? customSectionNotEmptyBool,
      checkedNetworkStatusModel: checkedNetworkStatusModel,
      connectedNetworkStatusModel: connectedNetworkStatusModel,
      lastConnectedNetworkStatusModel: lastConnectedNetworkStatusModel,
    );
  }

  const NetworkCustomSectionState._({
    required this.expandedBool,
    this.checkedNetworkStatusModel,
    this.connectedNetworkStatusModel,
    this.lastConnectedNetworkStatusModel,
  });

  NetworkCustomSectionState copyWith({
    bool? expandedBool,
    ANetworkStatusModel? checkedNetworkStatusModel,
    ANetworkStatusModel? connectedNetworkStatusModel,
    ANetworkStatusModel? lastConnectedNetworkStatusModel,
  }) {
    return NetworkCustomSectionState(
      expandedBool: expandedBool,
      checkedNetworkStatusModel: checkedNetworkStatusModel ?? this.checkedNetworkStatusModel,
      connectedNetworkStatusModel: connectedNetworkStatusModel ?? this.connectedNetworkStatusModel,
      lastConnectedNetworkStatusModel: lastConnectedNetworkStatusModel ?? this.lastConnectedNetworkStatusModel,
    );
  }

  bool containsUriWithEqualUrn(Uri uri) {
    bool urnInCheckedNetworkBool = NetworkUtils.compareUrisByUrn(checkedNetworkStatusModel?.uri, uri);
    bool urnInConnectedNetworkBool = NetworkUtils.compareUrisByUrn(connectedNetworkStatusModel?.uri, uri);
    bool urnInLastNetworkBool = NetworkUtils.compareUrisByUrn(lastConnectedNetworkStatusModel?.uri, uri);

    bool lastNetworkRelevantBool = connectedNetworkStatusModel == null;
    return urnInCheckedNetworkBool || urnInConnectedNetworkBool || (urnInLastNetworkBool && lastNetworkRelevantBool);
  }

  Uri? get uri {
    return checkedNetworkStatusModel?.uri ?? connectedNetworkStatusModel?.uri;
  }

  @override
  List<Object?> get props => <Object?>[expandedBool, checkedNetworkStatusModel, connectedNetworkStatusModel, lastConnectedNetworkStatusModel];
}
