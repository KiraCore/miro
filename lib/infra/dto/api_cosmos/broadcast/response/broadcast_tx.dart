import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/event.dart';

class BroadcastTx extends Equatable {
  final int code;
  final String codespace;
  final List<Event> events;
  final String info;
  final String log;
  final String? data;

  const BroadcastTx({
    required this.code,
    required this.codespace,
    required this.events,
    required this.info,
    required this.log,
    this.data,
  });

  factory BroadcastTx.fromJson(Map<String, dynamic> json) {
    return BroadcastTx(
      code: json['code'] as int,
      codespace: json['codespace'] as String,
      events: (json['events'] as List<dynamic>).map((dynamic e) => Event.fromJson(e as Map<String, dynamic>)).toList(),
      info: json['info'] as String,
      log: json['log'] as String,
      data: json['data'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[code, codespace, events, info, log, data];
}
