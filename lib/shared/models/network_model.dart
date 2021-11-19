import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/utils/network_utils.dart';

@immutable
class NetworkModel extends Equatable {
  final String name;
  final String url;
  final NetworkStatus status;
  final QueryInterxStatusResp? queryInterxStatus;
  final Uri parsedUri;

  bool get isConnected => queryInterxStatus != null;

  NetworkModel({
    required this.name,
    required this.url,
    required this.status,
    this.queryInterxStatus,
  }) : parsedUri = NetworkUtils.parseUrl(url);

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json['name'] as String,
        url: json['address'] as String,
        status: NetworkStatus.offline(),
      );

  factory NetworkModel.status({required NetworkModel from, required NetworkStatus status}) => NetworkModel(
        url: from.url,
        name: from.name,
        status: status,
      );

  NetworkModel copyWith({
    String? name,
    String? url,
    NetworkStatus? status,
    QueryInterxStatusResp? queryInterxStatus,
  }) {
    return NetworkModel(
      name: name ?? this.name,
      url: url ?? this.url,
      status: status ?? this.status,
      queryInterxStatus: queryInterxStatus ?? this.queryInterxStatus,
    );
  }

  @override
  List<Object> get props => <Object>[parsedUri];

  @override
  String toString() => 'NetworkModel{name: $name, url: $url, status: $status, NetworkData: $queryInterxStatus}';
}
