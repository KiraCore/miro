import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/msg_data.dart';

class Msg extends Equatable {
  final String type;
  final MsgData data;

  const Msg({
    required this.type,
    required this.data,
  });

  factory Msg.fromJson(Map<String, dynamic> json) {
    return Msg(
      type: json['type'] as String,
      data: MsgData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => <Object>[];

  @override
  String toString() {
    return 'Msg{type: $type, data: $data}';
  }
}
