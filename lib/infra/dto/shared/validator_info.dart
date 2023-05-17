import 'package:equatable/equatable.dart';

class ValidatorInfo extends Equatable {
  final String moniker;
  final String address;
  final String? logo;
  final String? valkey;
  final String? website;

  const ValidatorInfo({
    required this.moniker,
    required this.address,
    this.logo,
    this.valkey,
    this.website,
  });

  factory ValidatorInfo.fromJson(Map<String, dynamic> json) {
    return ValidatorInfo(
      moniker: json['moniker'] as String,
      address: json['address'] as String,
      logo: json['logo'] as String?,
      valkey: json['valkey'] as String?,
      website: json['website'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[moniker, address, logo, valkey, website];
}
