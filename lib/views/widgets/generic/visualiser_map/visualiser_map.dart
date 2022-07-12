import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network_visualiser/node_model.dart';
import 'package:miro/views/pages/menu/network_visualizer_page/geo_json_asset.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/visualiser_map/country_model.dart';
import 'package:miro/views/widgets/generic/visualiser_map/visualiser_canvas.dart';

class VisualiserMap extends StatefulWidget {
  final List<NodeModel> nodeModels;

  const VisualiserMap({
    required this.nodeModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualiserMap();
}

class _VisualiserMap extends State<VisualiserMap> {
  MapController mapController = MapController();
  bool mapLoading = true;
  List<Polygon> activePolygons = List<Polygon>.empty(growable: true);
  List<Polyline> activePolylines = List<Polyline>.empty(growable: true);
  List<CountryModel> countryModels = List<CountryModel>.empty(growable: true);

  @override
  void initState() {
    print(widget.nodeModels);
    super.initState();
    _loadMapLayer();
  }

  @override
  Widget build(BuildContext context) {
    if (mapLoading) {
      return const CenterLoadSpinner();
    }
    return VisualiserCanvas(
      countryModels: countryModels,
    );
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        zoom: 1.75,
        onTap: (_, LatLng point) {
          print('Tapped on ${point.toString()}');
        },
      ),
      layers: <LayerOptions>[
        TileLayerOptions(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            urlTemplate: 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png',
            tileBuilder: (BuildContext context, Widget tileWidget, Tile tile) {
              if (mapController.zoom < 5) {
                return Container();
              }
              return tileWidget;
            }),
        PolygonLayerOptions(
          polygons: activePolygons,
        ),
        // PolylineLayerOptions(
        //   polylines: activePolylines,
        // ),
      ],
      nonRotatedChildren: const <Widget>[],
    );
  }

  Future<void> _loadMapLayer() async {
    List<Polyline> lines = List<Polyline>.empty(growable: true);
    List<Polygon> polygons = List<Polygon>.empty(growable: true);
    String worldGeoJson = await GeoJsonAsset.world();
    GeoJsonFeatureCollection geoJsonFeatureCollection = await featuresFromGeoJsonMainThread(worldGeoJson);
    List<CountryModel> countryModels = List<CountryModel>.empty(growable: true);

    for (GeoJsonFeature<dynamic> feature in geoJsonFeatureCollection.collection) {
      if (feature.type == GeoJsonFeatureType.polygon) {
        GeoJsonFeature<GeoJsonPolygon> geoJsonPolygon = feature as GeoJsonFeature<GeoJsonPolygon>;
        countryModels.add(CountryModel(
          properties: geoJsonPolygon.properties!,
          geoSeries: geoJsonPolygon.geometry!.geoSeries,
          nodeModels: widget.nodeModels
              .where((NodeModel e) => e.nodeLocalization.countryCode == geoJsonPolygon.properties!['wb_a2'])
              .toList(),
        ));
      } else if (feature.type == GeoJsonFeatureType.multipolygon) {
        GeoJsonFeature<GeoJsonMultiPolygon> geoJsonMultiPolygon = feature as GeoJsonFeature<GeoJsonMultiPolygon>;
        for (GeoJsonPolygon geoJsonPolygon in geoJsonMultiPolygon.geometry!.polygons) {
          countryModels.add(CountryModel(
            properties: geoJsonMultiPolygon.properties!,
            geoSeries: geoJsonPolygon.geoSeries,
            nodeModels: widget.nodeModels
                .where((NodeModel e) => e.nodeLocalization.countryCode == geoJsonMultiPolygon.properties!['wb_a2'])
                .toList(),
          ));
        }
      }
    }

    for (CountryModel countryModel in countryModels) {
      polygons.add(Polygon(
        borderStrokeWidth: 2,
        isDotted: true,
        borderColor: DesignColors.blue1_20,
        points: countryModel.border,
        color: countryModel.countryColor,
      ));
    }
    setState(() {
      mapLoading = false;
      activePolygons = polygons;
      this.countryModels = countryModels;
    });
  }
}
