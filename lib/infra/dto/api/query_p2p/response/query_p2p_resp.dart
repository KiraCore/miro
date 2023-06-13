import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_p2p/response/node.dart';

class QueryP2PResp extends Equatable {
  final int lastUpdate;
  final List<Node> nodeList;

  const QueryP2PResp({
    required this.lastUpdate,
    required this.nodeList,
  });

  factory QueryP2PResp.fromJson(Map<String, dynamic> json) {
    return QueryP2PResp(
      lastUpdate: json['last_update'] as int,
      nodeList:
          json['node_list'] == null ? <Node>[] : ((json['node_list'] as List<dynamic>).map((dynamic e) => Node.fromJson(e as Map<String, dynamic>)).toList()),
    );
  }

  @override
  List<Object?> get props => <Object?>[lastUpdate, nodeList];
}
