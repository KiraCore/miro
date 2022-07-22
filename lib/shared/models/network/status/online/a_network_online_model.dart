import 'package:miro/shared/models/network/interx_error.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

abstract class ANetworkOnlineModel extends ANetworkStatusModel {
  final NetworkInfoModel networkInfoModel;

  const ANetworkOnlineModel({
    required this.networkInfoModel,
    required Uri uri,
    String? name,
  }) : super(
          uri: uri,
          name: name,
        );

  static ANetworkOnlineModel fromNetworkInfoModel({
    required Uri uri,
    required String name,
    required NetworkInfoModel networkInfoModel,
  }) {
    InterxError interxError = InterxError.fromNetworkInfoModel(networkInfoModel);

    if (interxError.hasErrors) {
      return NetworkUnhealthyModel(
        uri: uri,
        name: name,
        networkInfoModel: networkInfoModel,
        interxError: interxError,
      );
    } else {
      return NetworkHealthyModel(
        uri: uri,
        name: name,
        networkInfoModel: networkInfoModel,
      );
    }
  }
}
