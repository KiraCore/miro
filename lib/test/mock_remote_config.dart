import 'package:miro/config/remote_config.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/test/utils/test_utils.dart';

class MockRemoteConfig extends RemoteConfig {
  @override
  Future<void> init() async {}

  @override
  QueryKiraTokensAliasesResp getAliases() => TestUtils.queryKiraTokensAliasesResp;
}
