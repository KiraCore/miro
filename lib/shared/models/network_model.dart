import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/utils/network_utils.dart';

@immutable
class NetworkModel extends Equatable {
  final String name;
  final String url;
  final NetworkHealthStatus status;
  final QueryInterxStatusResp? queryInterxStatus;
  final QueryValidatorsResp? queryValidatorsResp;
  final Uri parsedUri;

  bool get isConnected => queryInterxStatus != null;

  NetworkModel({
    required this.name,
    required this.url,
    required this.status,
    this.queryValidatorsResp,
    this.queryInterxStatus,
  }) : parsedUri = NetworkUtils.parseUrl(url);

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json['name'] as String,
        url: json['address'] as String,
        status: NetworkHealthStatus.unknown,
      );

  NetworkModel copyWith({
    String? name,
    String? url,
    NetworkHealthStatus? status,
    QueryValidatorsResp? queryValidatorsResp,
    QueryInterxStatusResp? queryInterxStatus,
  }) {
    return NetworkModel(
      name: name ?? this.name,
      url: url ?? this.url,
      status: status ?? this.status,
      queryValidatorsResp: queryValidatorsResp ?? this.queryValidatorsResp,
      queryInterxStatus: queryInterxStatus ?? this.queryInterxStatus,
    );
  }

  @override
  String toString() => 'NetworkModel{name: $name, url: $url, status: $status, NetworkData: $queryInterxStatus}';

  @override
  List<Object?> get props => <Object?>[url, name, parsedUri, status, queryInterxStatus, queryValidatorsResp];
}
