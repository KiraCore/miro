import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';

class NodeMarker extends Marker {
  final VisualizerNodeModel visualizerNodeModel;

  NodeMarker({
    required this.visualizerNodeModel,
    required LatLng point,
    required Widget Function(BuildContext) builder,
    required double height,
    required double width,
    AnchorPos<AnchorAlign>? anchorPos,
  }) : super(
          point: point,
          builder: builder,
          height: height,
          width: width,
          anchorPos: anchorPos,
        );
}
