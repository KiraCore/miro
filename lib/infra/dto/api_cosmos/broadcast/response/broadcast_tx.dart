import 'package:miro/infra/dto/api_cosmos/broadcast/response/event.dart';

class BroadcastTx {
  final int code;
  final String codespace;
  final List<Event> events;
  final String gasUsed;
  final String gasWanted;
  final String info;
  final String log;
  final String? data;

  BroadcastTx({
    required this.code,
    required this.codespace,
    required this.events,
    required this.gasUsed,
    required this.gasWanted,
    required this.info,
    required this.log,
    this.data,
  });

  factory BroadcastTx.fromJson(Map<String, dynamic> json) {
    return BroadcastTx(
      code: json['code'] as int,
      codespace: json['codespace'] as String,
      events: (json['events'] as List<dynamic>).map((dynamic e) => Event.fromJson(e as Map<String, dynamic>)).toList(),
      gasUsed: json['gas_used'] as String,
      gasWanted: json['gas_wanted'] as String,
      info: json['info'] as String,
      log: json['log'] as String,
      data: json['data'] as String?,
    );
  }

  @override
  String toString() {
    return 'BroadcastTx{code: $code, codespace: $codespace, data: $data, events: $events, gasUsed: $gasUsed, gasWanted: $gasWanted, info: $info, log: $log}';
  }
}
