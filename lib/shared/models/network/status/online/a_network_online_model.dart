import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

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
}
