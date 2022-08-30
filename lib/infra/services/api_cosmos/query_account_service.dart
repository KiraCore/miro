import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _QueryAccountService {
  Future<QueryAccountResp> fetchQueryAccount(String address);
}

class QueryAccountService implements _QueryAccountService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryAccountResp> fetchQueryAccount(String address) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final QueryAccountResp response = await _apiCosmosRepository.fetchQueryAccount(
        networkUri,
        QueryAccountReq(address: address),
      );
      return response;
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryAccountService: Cannot fetch fetchQueryAccount() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'QueryAccountService: Cannot parse fetchQueryAccount() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
