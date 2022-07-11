import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/p2p_list/node.dart';

class P2PListResp extends Equatable {
  final int lastUpdate;
  final bool scanning;
  final List<Node> nodeList;

  const P2PListResp({
    required this.lastUpdate,
    required this.scanning,
    required this.nodeList,
  });

  factory P2PListResp.fromJson(Map<String, dynamic> json) {
    return P2PListResp(
      lastUpdate: json['last_update'] as int,
      scanning: json['scanning'] as bool,
      nodeList:
          (json['node_list'] as List<dynamic>).map((dynamic e) => Node.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[lastUpdate, scanning, nodeList];
}
