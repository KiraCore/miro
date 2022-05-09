import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/app_logger.dart';

class TokensProvider extends ChangeNotifier {
  Completer<QueryKiraTokensRatesResp>? ratesCompleter;
  Completer<QueryKiraTokensAliasesResp>? aliasesCompleter;

  Future<void> refreshData() async {
    await _updateTokenRates();
    await _updateTokenAliases();
    notifyListeners();
  }

  Future<QueryKiraTokensRatesResp> getQueryKiraTokensRatesResp() async {
    if (ratesCompleter == null) {
      await _updateTokenRates();
    }
    return await ratesCompleter!.future;
  }

  Future<QueryKiraTokensAliasesResp> getQueryKiraTokensAliasesResp() async {
    if (ratesCompleter == null) {
      await _updateTokenAliases();
    }
    return await aliasesCompleter!.future;
  }

  Future<void> _updateTokenRates() async {
    ratesCompleter = Completer<QueryKiraTokensRatesResp>();
    QueryKiraTokensRatesService queryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();
    try {
      ratesCompleter!.complete(queryKiraTokensRatesService.getTokenRates());
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch token rates. Error message: $e');
    }
  }

  Future<void> _updateTokenAliases() async {
    aliasesCompleter = Completer<QueryKiraTokensAliasesResp>();
    QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();
    try {
      aliasesCompleter!.complete(queryKiraTokensAliasesService.getTokenAliases());
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch token aliases. Error message: $e');
    }
  }
}
