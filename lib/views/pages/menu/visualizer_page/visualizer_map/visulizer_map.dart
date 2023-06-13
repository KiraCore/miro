import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:miro/blocs/pages/menu/visualizer/a_visualizer_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_error_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_loading_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_filter_dropdown.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_map/node_marker.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_map/node_marker_popup.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_map/node_marker_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class VisualizerMap extends StatefulWidget {
  final AVisualizerState visualizerState;
  final List<VisualizerNodeModel> nodeModelList;
  final TextEditingController searchBarTextEditingController;

  const VisualizerMap({
    required this.visualizerState,
    required this.nodeModelList,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualizerMapState();
}

class _VisualizerMapState extends State<VisualizerMap> {
  final MapController _mapController = MapController();
  final PopupController _popupLayerController = PopupController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool emptyListBool = widget.nodeModelList.isEmpty;
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Marker> markerList = _buildMarkerList();

    return Column(
      crossAxisAlignment: const ResponsiveValue<CrossAxisAlignment>(
        largeScreen: CrossAxisAlignment.start,
        smallScreen: CrossAxisAlignment.stretch,
      ).get(context),
      children: <Widget>[
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 64,
          child: Text(
            S.of(context).visualizerTitle,
            style: textTheme.displayMedium!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 480,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                maxZoom: 11,
                minZoom: 3,
                zoom: 3.0,
                center: LatLng(50, 8),
              ),
              nonRotatedChildren: <Widget>[
                if (emptyListBool)
                  Container(
                    decoration: const BoxDecoration(color: DesignColors.greyTransparent),
                  ),
                if (widget.visualizerState is VisualizerLoadingState)
                  const Center(
                    child: CircularProgressIndicator(
                      color: DesignColors.white1,
                    ),
                  ),
                if (widget.visualizerState is VisualizerErrorState)
                  Center(
                    child: Text(
                      S.of(context).errorCannotFetchData,
                      style: const TextStyle(color: DesignColors.redStatus1),
                    ),
                  ),
              ],
              children: <Widget>[
                TileLayer(
                  urlTemplate: 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}.png',
                  subdomains: const <String>[
                    'a',
                    'b',
                    'c',
                  ],
                  backgroundColor: DesignColors.grey3,
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    disableClusteringAtZoom: 16,
                    maxClusterRadius: 190,
                    size: const Size(40, 40),
                    fitBoundsOptions: const FitBoundsOptions(
                      padding: EdgeInsets.all(50),
                    ),
                    markers: markerList,
                    showPolygon: false,
                    popupOptions: PopupOptions(
                      markerRotate: false,
                      popupAnimation: const PopupAnimation.fade(
                        duration: Duration(milliseconds: 700),
                      ),
                      popupController: _popupLayerController,
                      popupBuilder: (BuildContext context, Marker marker) {
                        if (marker is NodeMarker) {
                          NodeMarker nodeMarker = marker;
                          return NodeMarkerPopup(marker, markerList, nodeMarker.visualizerNodeModel);
                        } else {
                          return const SizedBox();
                        }
                      },
                      popupState: PopupState(initiallySelectedMarkers: markerList),
                    ),
                    builder: (BuildContext context, List<Marker> markers) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: DesignColors.white1, shape: BoxShape.circle),
                        child: Text(
                          '${markers.length}',
                          style: const TextStyle(color: DesignColors.black),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        ResponsiveWidget(
          largeScreen: Row(
            children: <Widget>[
              const VisualizerFilterDropdown(),
              const Spacer(),
              ListSearchWidget<VisualizerNodeModel>(
                textEditingController: widget.searchBarTextEditingController,
                hint: S.of(context).visualizerSearchNodes,
              ),
            ],
          ),
          mediumScreen: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListSearchWidget<VisualizerNodeModel>(
                textEditingController: widget.searchBarTextEditingController,
                hint: S.of(context).visualizerSearchNodes,
              ),
              const SizedBox(height: 12),
              const VisualizerFilterDropdown(),
            ],
          ),
        )
      ],
    );
  }

  List<Marker> _buildMarkerList() {
    List<Marker> markerList = <Marker>[];
    for (VisualizerNodeModel visualizerNodeModel in widget.nodeModelList) {
      Marker marker = NodeMarker(
          width: 30,
          height: 30,
          point: LatLng(
            visualizerNodeModel.countryLatLongModel.latitude,
            visualizerNodeModel.countryLatLongModel.longitude,
          ),
          builder: (_) => const NodeMarkerWidget(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          visualizerNodeModel: visualizerNodeModel);
      markerList.add(marker);
    }
    return markerList;
  }
}
