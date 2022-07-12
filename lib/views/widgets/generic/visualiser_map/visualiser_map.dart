import 'package:flutter/cupertino.dart';
import 'package:geojson_vi/geojson_vi.dart';
import 'package:miro/views/pages/menu/network_visualizer_page/geo_json_asset.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:vector_map/vector_map.dart';

class VisualiserMap extends StatefulWidget {
  const VisualiserMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualiserMap();
}

class _VisualiserMap extends State<VisualiserMap> {
  bool mapLoading = true;
  late VectorMapController vectorMapController;

  @override
  void initState() {
    super.initState();
    _loadMapLayer();
  }

  @override
  Widget build(BuildContext context) {
    if (mapLoading) {
      return const CenterLoadSpinner();
    }
    return const Text('Loaded map');
  }

  Future<void> _loadMapLayer() async {
    String worldGeoJson = await GeoJsonAsset.world();
    final GeoJSONFeature geoJSONFeature = GeoJSONFeature.fromJSON(worldGeoJson);
    print(geoJSONFeature.);
    setState(() {});
  }
}
