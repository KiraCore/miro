import 'package:equatable/equatable.dart';

class Node extends Equatable {
  final bool connected;
  final String id;
  final String ip;
  final int peersNumber;
  final String countryCode;
  final String dataCenter;
  final int ping;
  final int port;
  final String? moniker;
  final String? address;
  final String? website;


  const Node({
    required this.connected,
    required this.id,
    required this.ip,
    required this.peersNumber,
    required this.countryCode,
    required this.dataCenter,
    required this.ping,
    required this.port,
    this.moniker,
    this.address,
    this.website,
});

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      connected: json['connected'] as bool,
      id: json['id'] as String,
      ip: json['ip'] as String,
      peersNumber: json['peers_number'] as int,
      countryCode: json['country_code'] as String,
      dataCenter: json['data_center'] as String,
      ping: json['ping'] as int,
      port: json['port'] as int,
      moniker: json['moniker'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[connected, id, ip, peersNumber, countryCode, dataCenter, ping, port];
}