import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/response/query_account_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryAccountService {
  Future<TxRemoteInfoModel> getTxRemoteInfo(String accountAddress);
}

class QueryAccountService implements _IQueryAccountService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<TxRemoteInfoModel> getTxRemoteInfo(String accountAddress) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryAccount<dynamic>(networkUri, QueryAccountReq(address: accountAddress));

    try {
      QueryAccountResp queryAccountResp = QueryAccountResp.fromJson(response.data as Map<String, dynamic>);
      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      TxRemoteInfoModel txRemoteInfoModel = TxRemoteInfoModel(
        accountNumber: queryAccountResp.accountNumber,
        chainId: interxHeaders.chainId,
        sequence: queryAccountResp.sequence,
      );
      return txRemoteInfoModel;
    } catch (e) {
      AppLogger().log(message: 'QueryAccountService: Cannot parse getTxRemoteInfo() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
