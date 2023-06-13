import 'dart:convert';
import 'package:flutter/services.dart';

abstract class IAssetsRepository {
  Future<List<Map<String, dynamic>>> fetchCountryLatLongList();
}

class AssetsRepository implements IAssetsRepository {
  @override
  Future<List<Map<String, dynamic>>> fetchCountryLatLongList() async {
    String response = await rootBundle.loadString('assets/country_codes_lat_long.json');
    List<dynamic> jsonResponse = await json.decode(response) as List<dynamic>;
    return jsonResponse.map((dynamic e) => e as Map<String, dynamic>).toList();
  }
}
