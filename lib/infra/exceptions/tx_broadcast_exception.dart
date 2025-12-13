import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';

class TxBroadcastException implements Exception {
  final BroadcastResp? broadcastResp;
  final Response<dynamic> response;

  TxBroadcastException({
    required this.broadcastResp,
    required this.response,
  });
}
