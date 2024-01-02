import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/governance_voters_resp.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters_permissions.dart';
import 'package:miro/infra/dto/api_kira/query_governance_votes/governance.votes_resp.dart';
import 'package:miro/infra/dto/api_kira/query_governance_votes/votes.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryGovernanceVoteService {
  Future<List<Votes>> getGovernanceVotes({required int proposalId});
  Future<List<Voters>> getGovernanceVoters({required int proposalId});
}

class QueryGovernanceVoteService implements _IQueryGovernanceVoteService {
  final IApiKiraRepository apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<Votes>> getGovernanceVotes({required int proposalId}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await apiKiraRepository.fetchQueryVotes<dynamic>(networkUri, proposalId);

    try {
      GovernanceProposalVotesResp governanceVotesResp = GovernanceProposalVotesResp.fromJsonList(response.data as List<dynamic>);

      List<Votes> votesList = governanceVotesResp.votes
          .map((Votes votes) => Votes(
                proposalId: votes.proposalId,
                voter: votes.voter,
                option: votes.option,
              ))
          .toList();
      return votesList;
    } catch (e) {
      AppLogger().log(message: 'QueryGovernanceVoteService: Cannot parse getGovernanceVotes() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<List<Voters>> getGovernanceVoters({required int proposalId}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await apiKiraRepository.fetchQueryVoters<dynamic>(networkUri, proposalId);

    try {
      GovernanceProposalVotersResp governanceVotersResp = GovernanceProposalVotersResp.fromJsonList(response.data as List<dynamic>);

      List<Voters> votersList = governanceVotersResp.voter
          .map((Voters voter) => Voters(
                address: voter.address,
                roles: voter.roles,
                status: voter.status,
                votes: voter.votes,
                permissions: VotersPermissions(blacklist: voter.permissions.blacklist, whitelist: voter.permissions.whitelist),
                skin: voter.skin,
              ))
          .toList();
      return votersList;
    } catch (e) {
      AppLogger().log(message: 'QueryGovernanceVotersService: Cannot parse getGovernanceVoters() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
