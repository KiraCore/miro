import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';

class NetworkUnhealthyModel extends ANetworkOnlineModel {
  final List<InterxError> interxErrors;

  const NetworkUnhealthyModel({
    required this.interxErrors,
    required Uri uri,
    required NetworkInfoModel networkInfoModel,
    String? name,
  }) : super(
          uri: uri,
          networkInfoModel: networkInfoModel,
          name: name,
        );

  bool get hasErrors {
    return interxErrors.isNotEmpty;
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, uri, name, networkInfoModel.hashCode];
}
