import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/network_defaults_model.dart';

abstract class ANetworkStatusModel extends Equatable {
  final ConnectionStatusType connectionStatusType;
  final Uri uri;
  final NetworkDefaultsModel? networkDefaultsModel;
  final Color _statusColor;
  final String? _name;

  const ANetworkStatusModel({
    required this.connectionStatusType,
    required this.uri,
    required this.networkDefaultsModel,
    required Color statusColor,
    String? name,
  })  : _statusColor = statusColor,
        _name = name;

  String get name {
    return _name ?? uri.host;
  }

  Color get statusColor {
    return _statusColor;
  }

  ANetworkStatusModel copyWith({required ConnectionStatusType connectionStatusType});
}
