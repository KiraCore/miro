import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required Uri uri,
    String? name,
  }) : super(
          uri: uri,
          name: name,
        );

  factory NetworkUnknownModel.fromJson(Map<String, dynamic> json) {
    return NetworkUnknownModel(uri: NetworkUtils.parseUrl(json['address'] as String), name: json['name'] as String);
  }

  factory NetworkUnknownModel.fromNetworkStatusModel(ANetworkStatusModel networkStatusModel) {
    return NetworkUnknownModel(
      uri: networkStatusModel.uri,
      name: networkStatusModel.name,
    );
  }

  NetworkUnknownModel withHttps() {
    return NetworkUnknownModel(
      uri: uri.replace(scheme: 'https'),
      name: name,
    );
  }

  bool isHttp() {
    return uri.scheme == 'http';
  }

  @override
  List<Object?> get props => <Object>[runtimeType, uri, name];
}
