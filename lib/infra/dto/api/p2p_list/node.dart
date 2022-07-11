import 'package:equatable/equatable.dart';

class Node extends Equatable {
  final String id;
  final String ip;
  final int port;
  final int ping;
  final bool connected;
  final List<String> peers;
  final bool alive;
  final bool synced;

  const Node({
    required this.id,
    required this.ip,
    required this.port,
    required this.ping,
    required this.connected,
    required this.peers,
    required this.alive,
    required this.synced,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'] as String,
      ip: json['ip'] as String,
      port: json['port'] as int,
      ping: json['ping'] as int,
      connected: json['connected'] as bool,
      peers: (json['peers'] as List<dynamic>).cast<String>(),
      alive: json['alive'] as bool,
      synced: json['synced'] as bool,
    );
  }

  @override
  List<Object?> get props => <Object>[
        id,
        ip,
        port,
        ping,
        connected,
        peers,
        alive,
        synced,
      ];
}
