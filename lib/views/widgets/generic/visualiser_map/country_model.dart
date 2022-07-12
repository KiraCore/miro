import 'package:flutter/material.dart';
import 'package:geopoint/src/models/geopoint.dart';
import 'package:geopoint/src/models/geoserie.dart';
import 'package:latlong2/latlong.dart';
import 'package:miro/shared/models/network_visualiser/node_model.dart';

class CountryModel {
  final Map<String, dynamic> properties;
  final List<NodeModel> nodeModels;
  late List<LatLng> border;

  CountryModel({
    required this.properties,
    required this.nodeModels,
    required List<GeoSerie> geoSeries,
  }) {
    border = geoSeries.fold(
        <LatLng>[],
        (List<LatLng> p, GeoSerie e) => <LatLng>[
              ...p,
              ...e.geoPoints.map((GeoPoint e) => LatLng(e.latitude, e.longitude > 180 ? 180 : e.longitude))
            ]).toList();
  }

  Color get countryColor {
    if (nodeModels.isNotEmpty) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
