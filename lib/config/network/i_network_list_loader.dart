import 'package:miro/shared/models/network/status/network_unknown_model.dart';

// ignore: one_member_abstracts
abstract class INetworkListLoader {
  Future<List<NetworkUnknownModel>> loadNetworkListConfig();
}
