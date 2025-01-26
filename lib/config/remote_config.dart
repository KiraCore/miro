import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';
import 'package:miro/shared/utils/string_extension.dart';

class RemoteConfig {
  // NOTE: use it as getter, so it can be mocked / omitted in tests
  FirebaseRemoteConfig get _config => FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _config.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _config.setDefaults(<String, dynamic>{
      'token_aliases': jsonEncode(<String, dynamic>{
        'min_client_version': '0.0.0',
        ..._defaultAliases.toJson(),
      }),
    });
    await _config.fetchAndActivate();
  }

  QueryKiraTokensAliasesResp getAliases() {
    Map<String, dynamic> aliases = jsonDecode(_config.getString('token_aliases')) as Map<String, dynamic>;
    if (globalLocator<AppConfig>()
        .packageInfo
        .version
        .isVersionLowerThan(aliases['min_client_version'] as String? ?? '0.0.0')) {
      AppLogger()
          .log(message: 'Client version is lower than ${aliases['min_client_version']}', logLevel: LogLevel.debug);
      // TODO(Mykyta): search through previous versions to get right one. Postponed till the moment we have a conflict
      return _defaultAliases;
    }
    return QueryKiraTokensAliasesResp.fromJson(aliases);
  }

  static const QueryKiraTokensAliasesResp _defaultAliases = QueryKiraTokensAliasesResp(
    tokenAliases: <TokenAlias>[
      TokenAlias(
        decimals: 6,
        denoms: <String>['ukex'],
        name: 'ukex',
        symbol: 'ukex',
        // TODO(Mykyta): make nullable
        icon: '',
        // TODO(Mykyta): make int, and get from api
        amount: '0',
      ),
    ],
    defaultDenom: 'ukex',
    bech32Prefix: 'kira',
  );
}
