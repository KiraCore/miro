import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/geolocation_db/geolocation_db_resp.dart';
import 'package:miro/infra/repositories/geolocation_db_repository.dart';
import 'package:miro/shared/models/network_visualiser/node_localization.dart';

abstract class _IGeolocationDbService {
  Future<NodeLocalization> getNodeLocalization(String ipAddress);

  Future<GeolocationDbResp> getLocationForIpAddress(String ipAddress);
}

class GeolocationDbService implements _IGeolocationDbService {
  final IGeolocationDbRepository _geolocationDbRepository = globalLocator<IGeolocationDbRepository>();

  @override
  Future<NodeLocalization> getNodeLocalization(String ipAddress) async {
    GeolocationDbResp geolocationDbResp = await getLocationForIpAddress(ipAddress);
    return NodeLocalization.fromDto(geolocationDbResp);
  }

  @override
  Future<GeolocationDbResp> getLocationForIpAddress(String ipAddress) async {
    try {
      final Response<dynamic> response = await _geolocationDbRepository.fetchLocationForIpAddress<dynamic>(ipAddress);
      GeolocationDbResp geolocationDbResp =
          GeolocationDbResp.fromJson(jsonDecode(response.data as String) as Map<String, dynamic>);
      return geolocationDbResp;
    } catch (e) {
      return const GeolocationDbResp(countryCode: 'null', countryName: 'null', latitude: 0, longitude: 0, ipv4: 'null');
    }
  }
}
