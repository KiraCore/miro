import 'package:equatable/equatable.dart';

abstract class ANetworkStatusModel extends Equatable {
  final Uri uri;
  final String? _name;

  const ANetworkStatusModel({
    required this.uri,
    String? name,
  }) : _name = name;

  String get name {
    return _name ?? uri.host;
  }
}
