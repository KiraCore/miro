import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/services/api/query_visualizer_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';

class VisualizerListController implements IListController<VisualizerNodeModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'visualizer');
  final QueryVisualizerService queryVisualizerService = globalLocator<QueryVisualizerService>();

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<VisualizerNodeModel>> getFavouritesData({bool forceRequestBool = false}) async {
    return List<VisualizerNodeModel>.empty();
  }

  @override
  Future<PageData<VisualizerNodeModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<VisualizerNodeModel> visualizerPageData = await queryVisualizerService.getVisualizerNodeModelList(
        QueryP2PReq(
          limit: paginationDetailsModel.limit,
          offset: paginationDetailsModel.offset,
        ),
        forceRequestBool: forceRequestBool);
    return visualizerPageData;
  }
}
