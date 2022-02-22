import 'package:flutter/cupertino.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/app_logger.dart';

class TokensProvider extends ChangeNotifier {
  QueryKiraTokensRatesResp? queryKiraTokensRatesResp;
  QueryKiraTokensAliasesResp? queryKiraTokensAliasesResp;

  bool get hasData {
    return queryKiraTokensRatesResp != null && queryKiraTokensAliasesResp != null;
  }

  Future<void> refreshData() async {
    await _updateTokenRates();
    await _updateTokenAliases();
    notifyListeners();
  }

  Future<void> _updateTokenRates() async {
    QueryKiraTokensRatesService queryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();
    try {
      queryKiraTokensRatesResp = await queryKiraTokensRatesService.getTokenRates();
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch token rates. Error message: $e');
    }
  }

  Future<void> _updateTokenAliases() async {
    QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();
    try {
      queryKiraTokensAliasesResp = await queryKiraTokensAliasesService.getTokenAliases();
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch token aliases. Error message: $e');
    }
  }
}
