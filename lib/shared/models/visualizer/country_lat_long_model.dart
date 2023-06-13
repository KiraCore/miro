import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/assets/country_lat_long_dto.dart';

class CountryLatLongModel extends Equatable {
  final double latitude;
  final double longitude;
  final String country;

  const CountryLatLongModel({
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  factory CountryLatLongModel.fromDto(CountryLatLongDto countryLatLong) {
    return CountryLatLongModel(
      latitude: countryLatLong.latitude,
      longitude: countryLatLong.longitude,
      country: countryLatLong.country,
    );
  }

  @override
  List<Object?> get props => <Object?>[latitude, longitude, country];
}
