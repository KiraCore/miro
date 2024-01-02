import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/governance_proposals_resp.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/proposal.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryGovernanceProposalService {
  Future<List<Proposal>> getGovernanceProposals();
}

class QueryGovernanceProposalService implements _IQueryGovernanceProposalService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<Proposal>> getGovernanceProposals() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryGovernanceProposals<dynamic>(networkUri);

    try {
      GovernanceProposalsResp governanceProposalsResp = GovernanceProposalsResp.fromJson(response.data as Map<String, dynamic>);

      List<Proposal> proposalsList = governanceProposalsResp.proposals
          .map((Proposal proposal) => Proposal(
                content: proposal.content,
                description: proposal.description,
                enactmentEndTime: proposal.enactmentEndTime,
                execResult: proposal.execResult,
                minEnactmentEndBlockHeight: proposal.minEnactmentEndBlockHeight,
                minVotingEndBlockHeight: proposal.minVotingEndBlockHeight,
                proposalId: proposal.proposalId,
                result: proposal.result,
                submitTime: proposal.submitTime,
                title: proposal.title,
                votingEndTime: proposal.votingEndTime,
              ))
          .toList();

      return proposalsList;
    } catch (e) {
      AppLogger().log(message: 'QueryGovernanceProposalService: Cannot parse getGovernanceProposals() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
