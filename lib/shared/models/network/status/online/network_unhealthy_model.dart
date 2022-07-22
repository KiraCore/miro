import 'package:miro/shared/models/network/interx_error.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkUnhealthyModel extends ANetworkOnlineModel {
  final InterxError interxError;

  const NetworkUnhealthyModel({
    required this.interxError,
    required Uri uri,
    required NetworkInfoModel networkInfoModel,
    String? name,
  }) : super(
          uri: uri,
          networkInfoModel: networkInfoModel,
          name: name,
        );

  @override
  List<Object?> get props => <Object?>[runtimeType, uri, name, networkInfoModel.hashCode];
}
