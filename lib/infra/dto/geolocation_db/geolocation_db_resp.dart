import 'package:equatable/equatable.dart';

class GeolocationDbResp extends Equatable {
  final String countryCode;
  final String countryName;
  final String? city;
  final String? postal;
  final double latitude;
  final double longitude;
  final String ipv4;
  final String? state;

  const GeolocationDbResp({
    required this.countryCode,
    required this.countryName,
    required this.latitude,
    required this.longitude,
    required this.ipv4,
    this.city,
    this.postal,
    this.state,
  });

  factory GeolocationDbResp.fromJson(Map<String, dynamic> json) {
    return GeolocationDbResp(
      countryCode: json['country_code'] as String,
      countryName: json['country_name'] as String,
      city: json['city'] as String?,
      postal: json['postal'] as String?,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      ipv4: json['IPv4'] as String,
      state: json['state'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        countryCode,
        countryName,
        city,
        postal,
        latitude,
        longitude,
        ipv4,
        state,
      ];
}
