import 'package:equatable/equatable.dart';

// TODO(MARCIN): update after requested endpoint modification by middleware team
class QueryP2PReq extends Equatable {
  /// This is an option to query only connected ips.
  final bool? connected;

  /// This is an option to query nodes in a specific format. usecase: order=simple
  final String? format;

  /// This is an option to query only ip addresses separated by comma.
  final bool? ipOnly;

  /// This is an option to query nodes in a specific order. usecase: order=random
  final String? order;

  /// This is an option to query only peers separated by comma. <node_id>@<ip>:<port>
  final bool? peersOnly;

  /// This is an option to validators pagination. offset is a numeric
  /// offset that can be used when key is unavailable.
  /// It is less efficient than using key. Only one of offset or key should be set
  final int? offset;

  /// This is an option to validators pagination. limit is the total number
  /// of results to be returned in the result page.
  /// If left empty it will default to a value to be set by each app.
  final int? limit;

  const QueryP2PReq({
    this.connected,
    this.format,
    this.ipOnly,
    this.order,
    this.peersOnly,
    this.offset,
    this.limit,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'connected': connected,
      'format': format,
      'ip_only': ipOnly,
      'order': order,
      'peers_only': peersOnly,
      'offset': offset,
      'limit': limit,
    };
  }

  @override
  List<Object?> get props => <Object?>[connected, format, ipOnly, order, peersOnly, offset, limit];
}
