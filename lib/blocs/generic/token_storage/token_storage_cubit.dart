import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/token_storage/token_storage_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class TokenStorageCubit extends Cubit<TokenStorageState> {
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();
  final NetworkInfoService networkInfoService = NetworkInfoService();
  Completer<void> reloadCompleter = Completer<void>();

  TokenStorageCubit() : super(const TokenStorageState()) {
    networkModuleBloc.stream.listen((_) => _reload());
  }

  Future<String> getBech32Prefix() async {
    await reloadCompleter.future;
    return state.defaultAddressPrefix!;
  }

  Future<TokenAliasModel> getTokenAliasForDenom(String denom) async {
    await reloadCompleter.future;
    return state.tokenAliasMap?[denom] ?? TokenAliasModel.local(denom);
  }

  Future<TokenAliasModel> getDefaultTokenAlias() async {
    await reloadCompleter.future;
    return state.defaultTokenAliasModel!;
  }

  Future<void> _reload() async {
    reloadCompleter = Completer<void>();

    Map<String, TokenAliasModel> tokenAliasMap = await queryKiraTokensAliasesService.getTokenAliasModelsMap();
    NetworkInfoModel networkInfoModel = await networkInfoService.getNetworkInfo();

    emit(TokenStorageState(
      defaultAddressPrefix: networkInfoModel.defaultAddressPrefix,
      defaultTokenAliasModel: tokenAliasMap[networkInfoModel.defaultDenom] ?? TokenAliasModel.local(networkInfoModel.defaultDenom),
      tokenAliasMap: tokenAliasMap,
    ));

    reloadCompleter.complete();
  }
}

class NetworkInfoService {
  Future<NetworkInfoModel> getNetworkInfo() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    if (networkUri.host == '65.108.86.252') {
      return const NetworkInfoModel(
        defaultDenom: 'ukex',
        defaultAddressPrefix: 'kira',
      );
    } else {
      return const NetworkInfoModel(
        defaultDenom: 'atom',
        defaultAddressPrefix: 'cosmos',
      );
    }
  }
}

class NetworkInfoModel extends Equatable {
  final String defaultDenom;
  final String defaultAddressPrefix;

  const NetworkInfoModel({
    required this.defaultDenom,
    required this.defaultAddressPrefix,
  });

  @override
  List<Object?> get props => <Object?>[defaultDenom, defaultAddressPrefix];
}
