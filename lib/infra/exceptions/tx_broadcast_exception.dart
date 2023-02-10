import 'package:dio/dio.dart';
import 'package:miro/shared/models/transactions/broadcast_error_log_model.dart';

class TxBroadcastException implements Exception {
  final BroadcastErrorLogModel broadcastErrorLogModel;
  final Response<dynamic> response;

  TxBroadcastException({
    required this.broadcastErrorLogModel,
    required this.response,
  });
}
