import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkOfflineModel extends ANetworkStatusModel {
  const NetworkOfflineModel({
    required Uri uri,
    String? name,
  }) : super(
          uri: uri,
          name: name,
        );

  factory NetworkOfflineModel.fromRequest(NetworkUnknownModel networkUnknownModel) {
    return NetworkOfflineModel(
      uri: networkUnknownModel.uri,
      name: networkUnknownModel.name,
    );
  }

  @override
  List<Object?> get props => <Object>[runtimeType, uri, name];
}
