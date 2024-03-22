import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

abstract class ANetworkStatusModel extends Equatable {
  final Color _statusColor;
  final ConnectionStatusType connectionStatusType;
  final TokenDefaultDenomModel tokenDefaultDenomModel;
  final Uri uri;
  final DateTime? lastRefreshDateTime;
  final String? _name;

  const ANetworkStatusModel({
    required Color statusColor,
    required this.connectionStatusType,
    required this.tokenDefaultDenomModel,
    required this.uri,
    this.lastRefreshDateTime,
    String? name,
  })  : _statusColor = statusColor,
        _name = name;

  String get name {
    return _name ?? uri.host;
  }

  Color get statusColor {
    return _statusColor;
  }

  ANetworkStatusModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime});
}
