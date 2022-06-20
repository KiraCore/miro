import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';

class InterxStatusWrapper {
  /// QueryInterxStatus is a first query used after run application.
  /// It's used to validate network url and download data about network
  /// Because user can provide URL without scheme or use an HTTP address when HTTPS is necessary,
  /// service returns URI, which was finally used to execute the query
  ///
  /// Example:
  /// 1. User wants to connect to http://testnet-rpc.kira.network/
  /// 2. Server returns ERR_CONNECTION_REFUSED, because testnet-rpc.kira.network endpoint not working in HTTP scheme
  /// 3. Miro tries to connect again using HTTPS
  /// 4. Server return response, so query is successful. Set used uri as https://testnet-rpc.kira.network/ and
  ///    return response
  final Uri usedUri;

  /// Response from /api/status endpoint
  final QueryInterxStatusResp queryInterxStatusResp;

  InterxStatusWrapper({
    required this.usedUri,
    required this.queryInterxStatusResp,
  });

  @override
  String toString() {
    return 'InterxResponseData{usedUri: $usedUri, queryInterxStatusResp: $queryInterxStatusResp}';
  }
}
