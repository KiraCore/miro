import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/assets/country_lat_long_dto.dart';
import 'package:miro/infra/repositories/assets/assets_repository.dart';
import 'package:miro/shared/models/visualizer/country_lat_long_model.dart';

abstract class ICountryLatLongService {
  Future<Map<String, CountryLatLongModel>> getCountryCodeMap();
}

class CountryLatLongService implements ICountryLatLongService {
  final IAssetsRepository _assetsRepository = globalLocator<IAssetsRepository>();

  @override
  Future<Map<String, CountryLatLongModel>> getCountryCodeMap() async {
    List<Map<String, dynamic>> jsonResponse = await _assetsRepository.fetchCountryLatLongList();
    Map<String, CountryLatLongModel> countryCodeMap = <String, CountryLatLongModel>{};
    for (Map<String, dynamic> e in jsonResponse) {
      CountryLatLongDto countryLatLongDto = CountryLatLongDto.fromJson(e);
      countryCodeMap[countryLatLongDto.alpha2] = CountryLatLongModel.fromDto(countryLatLongDto);
      countryCodeMap[countryLatLongDto.alpha3] = CountryLatLongModel.fromDto(countryLatLongDto);
    }
    return countryCodeMap;
  }
}
