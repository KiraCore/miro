import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/p2p_list_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/network_visualiser/node_model.dart';
import 'package:miro/views/pages/menu/network_visualizer_page/geo_json_asset.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:provider/provider.dart';
import 'package:vector_map/vector_map.dart';

class NetworkVisualiserPage extends StatelessWidget {
  const NetworkVisualiserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NetworkProvider>(
        builder: (_, NetworkProvider networkProvider, Widget? child) {
          if (!networkProvider.isConnected) {
            return Text('No connection: ${networkProvider.state}');
          }
          return FutureBuilder<List<NodeModel>>(
            future: globalLocator<P2PListService>().getPubNodes(),
            builder: (BuildContext context, AsyncSnapshot<List<NodeModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CenterLoadSpinner();
              }
              return VisualiserLoaded(
                nodeModels: snapshot.data!,
              );
            },
          );
        },
      ),
    );
  }
}

class VisualiserLoaded extends StatefulWidget {
  final List<NodeModel> nodeModels;

  const VisualiserLoaded({
    required this.nodeModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualiserLoaded();
}

class _VisualiserLoaded extends State<VisualiserLoaded> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(
          tabs: <Tab>[
            Tab(text: 'list'),
            Tab(text: 'map'),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            VisualiserList(nodeModels: widget.nodeModels),
            VisualiserMap(nodeModels: widget.nodeModels),
          ],
        ),
      ),
    );
  }
}

class VisualiserList extends StatelessWidget {
  final List<NodeModel> nodeModels;

  const VisualiserList({
    required this.nodeModels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: nodeModels.length,
        itemBuilder: (BuildContext context, int index) {
          NodeModel nodeModel = nodeModels[index];
          return ListTile(
            title: SelectableText(nodeModel.ip),
            subtitle: Text(nodeModel.nodeLocalization.toString()),
          );
        },
      ),
    );
  }
}

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
  late VectorMapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VectorMapController();
    _loadGeoJson();
  }

  Future<void> _loadGeoJson() async {
    String worldGeoJson = await GeoJsonAsset.world();

    MapDataSource world = await MapDataSource.geoJson(geoJson: worldGeoJson);
    _controller.addLayer(MapLayer(dataSource: world, theme: MapTheme(contourColor: Colors.white, color: Colors.grey)));
  }

  @override
  Widget build(BuildContext context) {
    VectorMap map = VectorMap(controller: _controller);
    return map;
  }
}
