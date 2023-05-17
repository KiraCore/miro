import 'package:equatable/equatable.dart';

class SoftwareUpgradeResource extends Equatable {
  final String checksum;
  final String id;
  final String url;
  final String version;

  const SoftwareUpgradeResource({
    required this.checksum,
    required this.id,
    required this.url,
    required this.version,
  });

  factory SoftwareUpgradeResource.fromJson(Map<String, dynamic> json) {
    return SoftwareUpgradeResource(
      checksum: json['checksum'] as String,
      id: json['id'] as String,
      url: json['url'] as String,
      version: json['version'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[checksum, id, url, version];
}
