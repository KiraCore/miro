import 'package:miro/shared/models/tokens/token_alias_model.dart';

/// This class stores every token alias that was queried at least once.
/// The aliases are stored as TokenAliasModels in nested maps, classified by
/// token default denomination name and to the URI the query was done for.
/// ex.: {'http://173.212.254.147:11000': {'ukex': TokenAliasModel(...)}}
class TokenAliasesMemory {
  late Map<Uri, Map<String, TokenAliasModel>> _tokenAliasModelMap;

  TokenAliasesMemory() {
    _tokenAliasModelMap = <Uri, Map<String, TokenAliasModel>>{};
  }

  void saveResponse(List<TokenAliasModel> queriedTokenAliasModels, Uri networkUri) {
    if (_tokenAliasModelMap[networkUri] == null) {
      _tokenAliasModelMap[networkUri] = <String, TokenAliasModel>{};
    }

    for (TokenAliasModel tokenAliasModel in queriedTokenAliasModels) {
      String tokenName = tokenAliasModel.defaultTokenDenominationModel.name;
      _tokenAliasModelMap[networkUri]![tokenName] = tokenAliasModel;
    }
  }

  List<TokenAliasModel> getTokenAliasesByNames(List<String> tokenNames, Uri networkUri) {
    if (_tokenAliasModelMap[networkUri] == null) {
      _tokenAliasModelMap[networkUri] = <String, TokenAliasModel>{};
    }

    return tokenNames.map((String tokenName) => _tokenAliasModelMap[networkUri]![tokenName]).whereType<TokenAliasModel>().toList();
  }

  TokenAliasModel? getTokenAliasByName(String tokenName, Uri networkUri) {
    if (_tokenAliasModelMap[networkUri] == null) {
      _tokenAliasModelMap[networkUri] = <String, TokenAliasModel>{};
    }

    return _tokenAliasModelMap[networkUri]![tokenName];
  }

  List<TokenAliasModel> getTokenAliasModelList(Uri networkUri) => _tokenAliasModelMap[networkUri]?.values.toList() ?? List<TokenAliasModel>.empty();
}
