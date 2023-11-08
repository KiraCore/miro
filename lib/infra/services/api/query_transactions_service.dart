import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/dto/api/query_transactions/response/query_transactions_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryTransactionsService {
  Future<PageData<TxListItemModel>> getTransactionList(QueryTransactionsReq queryTransactionsReq);
}

class QueryTransactionsService implements _IQueryTransactionsService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<PageData<TxListItemModel>> getTransactionList(QueryTransactionsReq queryTransactionsReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiRepository.fetchQueryTransactions<dynamic>(ApiRequestModel<QueryTransactionsReq>(
      networkUri: networkUri,
      requestData: queryTransactionsReq,
    ));

    try {
      QueryTransactionsResp queryTransactionsResp = QueryTransactionsResp.fromJson(response.data as Map<String, dynamic>);
      List<TxListItemModel> txListItemModelList = queryTransactionsResp.transactions.map(TxListItemModel.fromDto).toList();

      return PageData<TxListItemModel>(
        listItems: txListItemModelList,
        lastPageBool: txListItemModelList.length < queryTransactionsReq.limit!,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryTransactionsService: Cannot parse getTransactionList() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
