import 'package:miro/infra/dto/api/p2p_list/node.dart';
import 'package:miro/shared/models/network_visualiser/node_localization.dart';

class NodeModel {
  final String ip;
  final NodeLocalization nodeLocalization;

  NodeModel({
    required this.ip,
    required this.nodeLocalization,
  });

  factory NodeModel.fromDto(Node node, NodeLocalization nodeLocalization) {
    return NodeModel(
      ip: node.ip,
      nodeLocalization: nodeLocalization,
    );
  }

  @override
  String toString() {
    return 'NodeModel(ip: \'$ip\', nodeLocalization: $nodeLocalization)\n';
  }
}
