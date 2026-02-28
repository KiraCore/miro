import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_blocks/request/query_blocks_req.dart';
import 'package:miro/infra/dto/api/query_blocks/response/query_blocks_resp.dart';
import 'package:miro/infra/dto/api/query_blocks_transactions/request/query_block_transactions_req.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/dto/api/query_transactions/response/query_transactions_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryTransactionsService {
  Future<PageData<TxListItemModel>> getTransactionList(QueryTransactionsReq queryTransactionsReq);

  Future<PageData<TxListItemModel>> getBlockTransactions(QueryBlockTransactionsReq queryBlockTransactionsReq);

  Future<PageData<BlockModel>> getBlocks(QueryBlocksReq queryBlocksReq);
}

class QueryTransactionsService implements _IQueryTransactionsService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<PageData<TxListItemModel>> getTransactionList(QueryTransactionsReq queryTransactionsReq,
      {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response =
        await _apiRepository.fetchQueryTransactions<dynamic>(ApiRequestModel<QueryTransactionsReq>(
      networkUri: networkUri,
      requestData: queryTransactionsReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryTransactionsResp queryTransactionsResp =
          QueryTransactionsResp.fromJson(response.data as Map<String, dynamic>);
      List<TxListItemModel> txListItemModelList =
          queryTransactionsResp.transactions.map(TxListItemModel.fromDto).toList();

      QueryInterxStatusResp statusResp = await QueryInterxStatusService().getQueryInterxStatusResp(networkUri);

      return PageData<TxListItemModel>(
        listItems: txListItemModelList,
        lastPageBool: txListItemModelList.length < queryTransactionsReq.limit!,
        blockDateTime: statusResp.syncInfo.latestBlockTime,
      );
    } catch (e) {
      AppLogger().log(
          message: 'QueryTransactionsService: Cannot parse getTransactionList() for URI $networkUri ${e}',
          logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<PageData<TxListItemModel>> getBlockTransactions(QueryBlockTransactionsReq queryBlockTransactionsReq,
      {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response =
        await _apiRepository.fetchQueryBlockTransactions<dynamic>(ApiRequestModel<QueryBlockTransactionsReq>(
      networkUri: networkUri,
      requestData: queryBlockTransactionsReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryTransactionsResp queryTransactionsResp =
          QueryTransactionsResp.fromJson(response.data as Map<String, dynamic>);
      List<TxListItemModel> txListItemModelList =
          queryTransactionsResp.transactions.map(TxListItemModel.fromDto).toList();

      QueryInterxStatusResp statusResp = await QueryInterxStatusService().getQueryInterxStatusResp(networkUri);

      return PageData<TxListItemModel>(
        listItems: txListItemModelList,
        lastPageBool: txListItemModelList.length < queryBlockTransactionsReq.limit!,
        blockDateTime: statusResp.syncInfo.latestBlockTime,
      );
    } catch (e) {
      AppLogger().log(
          message: 'QueryTransactionsService: Cannot parse getBlockTransactions() for URI $networkUri ${e}',
          logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<PageData<BlockModel>> getBlocks(QueryBlocksReq queryBlocksReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiRepository.fetchQueryBlocks<dynamic>(ApiRequestModel<QueryBlocksReq>(
      networkUri: networkUri,
      requestData: queryBlocksReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryBlocksResp queryBlocksResp = QueryBlocksResp.fromJson(response.data as Map<String, dynamic>);

      QueryInterxStatusResp statusResp = await QueryInterxStatusService().getQueryInterxStatusResp(networkUri);

      return PageData<BlockModel>(
        listItems: queryBlocksResp.blocks,
        lastPageBool: queryBlocksResp.blocks.length < queryBlocksReq.limit!,
        blockDateTime: statusResp.syncInfo.latestBlockTime,
      );
    } catch (e) {
      AppLogger().log(
          message: 'QueryTransactionsService: Cannot parse getBlocks() for URI $networkUri ${e}',
          logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
