import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/request/query_undelegations_req.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/response/query_undelegations_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryUndelegationsService {
  Future<PageData<UndelegationModel>> getUndelegationModelList(QueryUndelegationsReq queryUndelegationsReq);
}

class QueryUndelegationsService implements _IQueryUndelegationsService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<PageData<UndelegationModel>> getUndelegationModelList(QueryUndelegationsReq queryUndelegationsReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryUndelegations<dynamic>(ApiRequestModel<QueryUndelegationsReq>(
      networkUri: networkUri,
      requestData: queryUndelegationsReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryUndelegationsResp queryUndelegationsResp = QueryUndelegationsResp.fromJson(response.data as Map<String, dynamic>);
      List<UndelegationModel> stakingModelList = queryUndelegationsResp.undelegations.map(UndelegationModel.fromDto).toList();

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<UndelegationModel>(
        listItems: stakingModelList,
        lastPageBool: stakingModelList.length < queryUndelegationsReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryUndelegationsService: Cannot parse getUndelegationModelList() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
