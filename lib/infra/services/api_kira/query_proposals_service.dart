import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/request/query_proposals_req.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/query_proposals_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryProposalsService {
  Future<PageData<ProposalModel>> getProposals(QueryProposalsReq queryProposalsReq);
}

class QueryProposalsService implements _IQueryProposalsService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<PageData<ProposalModel>> getProposals(QueryProposalsReq queryProposalsReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiKiraRepository.fetchQueryProposals<dynamic>(ApiRequestModel<QueryProposalsReq>(
      networkUri: networkUri,
      requestData: queryProposalsReq,
    ));

    try {
      QueryProposalsResp queryProposalsResp = QueryProposalsResp.fromJson(response.data as Map<String, dynamic>);
      List<ProposalModel> proposalsList = queryProposalsResp.proposals.map(ProposalModel.fromDto).toList();

      return PageData<ProposalModel>(
        listItems: proposalsList,
        lastPageBool: proposalsList.length < queryProposalsReq.limit!,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryProposalsService: Cannot parse getProposals() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
