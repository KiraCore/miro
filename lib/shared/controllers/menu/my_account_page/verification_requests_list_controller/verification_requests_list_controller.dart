import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class VerificationRequestsListController implements IListController<IRInboundVerificationRequestModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'ir_inbound_verifications');
  final IdentityRecordsService identityRecordsService = globalLocator<IdentityRecordsService>();
  final WalletAddress walletAddress;

  VerificationRequestsListController({
    required this.walletAddress,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<IRInboundVerificationRequestModel>> getFavouritesData() async {
    return List<IRInboundVerificationRequestModel>.empty(growable: true);
  }

  @override
  Future<List<IRInboundVerificationRequestModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<IRInboundVerificationRequestModel> irVerificationRequestModelList =
        await identityRecordsService.getInboundVerificationRequests(walletAddress, offset, limit);
    return irVerificationRequestModelList;
  }
}
