import 'package:miro/infra/repositories/assets/assets_repository.dart';
import 'package:miro/test/mocks/assets/mock_assets_country_lat_long_list.dart';

class MockAssetsRepository implements IAssetsRepository {
  @override
  Future<List<Map<String, dynamic>>> fetchCountryLatLongList() async {
    return MockCountryCodesLatLongJson.countryCodeMap;
  }
}
