import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/interx_status/interx_status.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/shared/utils/network_utils.dart';

@immutable
class NetworkModel extends Equatable {
  final String name;
  final String url;
  final NetworkStatus status;
  final InterxStatus? interxStatus;
  final Uri parsedUri;

  bool get isConnected => interxStatus != null;

  NetworkModel({
    required this.name,
    required this.url,
    required this.status,
    this.interxStatus,
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

  factory NetworkModel.connected({required NetworkModel from, required InterxStatus status}) => NetworkModel(
    url: from.url,
    name: from.name,
    status: NetworkStatus.online(),
    interxStatus: status,
  );

  @override
  List<Object> get props => <Object>[parsedUri];

  @override
  String toString() => 'NetworkModel{name: $name, url: $url, status: $status, NetworkData: $interxStatus}';
}
