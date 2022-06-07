import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkHealthyModel extends ANetworkOnlineModel {
  const NetworkHealthyModel({
    required NetworkInfoModel networkInfoModel,
    required Uri uri,
    String? name,
  }) : super(
          uri: uri,
          networkInfoModel: networkInfoModel,
          name: name,
        );

  @override
  List<Object?> get props => <Object?>[runtimeType, uri, name, networkInfoModel.hashCode];
}
