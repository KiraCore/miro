import 'package:miro/infra/dto/api/query_transaction_result/response/data.dart';
import 'package:miro/infra/dto/shared/coin.dart';

class Msg {
  final String type;
  final Data data;

  Msg({required this.type, required this.data});

  factory Msg.fromJson(Map<String, dynamic> json) {
    return Msg(
      type: json['type'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
