import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/visualizer/country_lat_long_model.dart';

class VisualizerNodeModel extends AListItem {
  final int peersNumber;
  final String ip;
  final String dataCenter;
  final String moniker;
  final String? address;
  final String? website;
  final CountryLatLongModel countryLatLongModel;
  bool _favourite = false;

  VisualizerNodeModel({
    required this.peersNumber,
    required this.ip,
    required this.dataCenter,
    required this.countryLatLongModel,
    this.moniker = 'Unknown',
    this.address,
    this.website,
  });

  VisualizerNodeModel copyWith({
    int? peersNumber,
    String? ip,
    String? dataCenter,
    String? moniker,
    String? address,
    String? website,
    CountryLatLongModel? countryLatLongModel,
  }) {
    return VisualizerNodeModel(
      peersNumber: peersNumber ?? this.peersNumber,
      ip: ip ?? this.ip,
      dataCenter: dataCenter ?? this.dataCenter,
      moniker: moniker ?? this.moniker,
      address: address ?? this.address,
      website: website ?? this.website,
      countryLatLongModel: countryLatLongModel ?? this.countryLatLongModel,
    );
  }

  @override
  String get cacheId => ip;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'VisualizerNodeModel{peersNumber: $peersNumber, ip: $ip, dataCenter: $dataCenter, moniker: $moniker, address: $address, website: $website, countryLatLongModel: $countryLatLongModel}';
  }
}
