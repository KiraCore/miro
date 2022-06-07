import 'package:miro/shared/models/network/status/a_network_status_model.dart';

// ignore: one_member_abstracts
abstract class INetworkListLoader {
  Future<List<ANetworkStatusModel>> loadNetworkListConfig();
}
