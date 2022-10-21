import 'package:equatable/equatable.dart';

class ProtocolVersion extends Equatable {
  final String app;
  final String block;
  final String p2p;

  const ProtocolVersion({
    required this.app,
    required this.block,
    required this.p2p,
  });

  factory ProtocolVersion.fromJson(Map<String, dynamic> json) => ProtocolVersion(
        app: json['app'] as String,
        block: json['block'] as String,
        p2p: json['p2p'] as String,
      );

  @override
  List<Object?> get props => <Object?>[app, block, p2p];
}
