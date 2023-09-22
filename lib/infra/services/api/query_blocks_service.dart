import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_blocks/request/query_blocks_req.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_meta.dart';
import 'package:miro/infra/dto/api/query_blocks/response/query_blocks_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryBlocksService {
  Future<PageData<BlockModel>> getBlockList(QueryBlocksReq queryBlocksReq);
}

class QueryBlocksService implements _IQueryBlocksService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<PageData<BlockModel>> getBlockList(QueryBlocksReq queryBlocksReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiRepository.fetchQueryBlocks<dynamic>(
      ApiRequestModel<QueryBlocksReq>(
        networkUri: networkUri,
        requestData: queryBlocksReq,
        forceRequestBool: forceRequestBool,
      ),
    );

    try {
      QueryBlocksResp queryBlocksResp = QueryBlocksResp.fromJson(response.data as Map<String, dynamic>);
      List<BlockMeta> blockMetas = queryBlocksResp.blockMetas;
      List<BlockModel> blockModelList = blockMetas.map((dynamic e) => BlockModel.fromDto(e as BlockMeta)).toList();

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<BlockModel>(
        listItems: blockModelList,
        lastPageBool: blockModelList.length < queryBlocksReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryBlocksService: Cannot parse getBlockList() for URI $networkUri: $e', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
