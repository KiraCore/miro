import 'package:equatable/equatable.dart';

class CountryLatLongDto extends Equatable {
  final double latitude;
  final double longitude;
  final int numeric;
  final String alpha2;
  final String alpha3;
  final String country;

  const CountryLatLongDto({
    required this.latitude,
    required this.longitude,
    required this.numeric,
    required this.alpha2,
    required this.alpha3,
    required this.country,
  });

  factory CountryLatLongDto.fromJson(Map<String, dynamic> json) {
    return CountryLatLongDto(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      numeric: json['numeric'] as int,
      alpha2: json['alpha2'] as String,
      alpha3: json['alpha3'] as String,
      country: json['country'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[latitude, longitude, numeric, alpha2, alpha3, country];
}
