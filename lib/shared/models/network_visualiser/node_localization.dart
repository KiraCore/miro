import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/geolocation_db/geolocation_db_resp.dart';

class NodeLocalization extends Equatable {
  final String countryCode;
  final String countryName;
  final double lat;
  final double lng;
  final String? city;
  final String? postal;
  final String? state;

  const NodeLocalization({
    required this.countryCode,
    required this.countryName,
    required this.lat,
    required this.lng,
    this.city,
    this.postal,
    this.state,
  });

  factory NodeLocalization.fromDto(GeolocationDbResp geolocationDbResp) {
    return NodeLocalization(
      countryCode: geolocationDbResp.countryCode,
      countryName: geolocationDbResp.countryName,
      lat: geolocationDbResp.latitude,
      lng: geolocationDbResp.longitude,
      city: geolocationDbResp.city,
      postal: geolocationDbResp.postal,
      state: geolocationDbResp.state,
    );
  }

  @override
  String toString() {
    return 'NodeLocalization{countryCode: $countryCode, countryName: $countryName, lat: $lat, lng: $lng, city: $city, postal: $postal, state: $state}';
  }

  @override
  List<Object?> get props => <Object?>[
        countryCode,
        countryName,
        lat,
        lng,
        city,
        postal,
        state,
      ];
}
