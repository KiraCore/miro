import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';

abstract class ANetworkStatusModel extends Equatable {
  final ConnectionStatusType connectionStatusType;
  final Uri uri;
  final String? _name;

  const ANetworkStatusModel({
    required this.connectionStatusType,
    required this.uri,
    String? name,
  }) : _name = name;

  String get name {
    return _name ?? uri.host;
  }

  ANetworkStatusModel copyWith({required ConnectionStatusType connectionStatusType});
}
