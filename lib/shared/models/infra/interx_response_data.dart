import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';

class InterxResponseData {
  final Uri usedUri;
  final QueryInterxStatusResp queryInterxStatusResp;

  InterxResponseData({
    required this.usedUri,
    required this.queryInterxStatusResp,
  });

  @override
  String toString() {
    return 'InterxResponseData{usedUri: $usedUri, queryInterxStatusResp: $queryInterxStatusResp}';
  }
}
