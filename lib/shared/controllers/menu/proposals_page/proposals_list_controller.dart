import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/request/query_proposals_req.dart';
import 'package:miro/infra/services/api_kira/query_proposals_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';

class ProposalsListController implements IListController<ProposalModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'proposals');
  final QueryProposalsService queryProposalService = globalLocator<QueryProposalsService>();

  FilterOption<ProposalModel>? filteringByStartDate;
  FilterOption<ProposalModel>? filteringByEndDate;

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<ProposalModel>> getFavouritesData() async {
    return <ProposalModel>[];
  }

  @override
  Future<PageData<ProposalModel>> getPageData(PaginationDetailsModel paginationDetailsModel) async {
    PageData<ProposalModel> proposalsPageData = await queryProposalService.getProposals(
      QueryProposalsReq(
        offset: paginationDetailsModel.offset,
        limit: paginationDetailsModel.limit,
      ),
    );
    return proposalsPageData;
  }
}
