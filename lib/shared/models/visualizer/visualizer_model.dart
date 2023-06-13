import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';

class VisualizerModel extends Equatable {
  final int lastUpdate;
  final List<VisualizerNodeModel> nodeModelList;

  const VisualizerModel({
    required this.lastUpdate,
    required this.nodeModelList,
  });

  VisualizerModel copyWith({
    int? lastUpdate,
    List<VisualizerNodeModel>? nodeModelList,
  }) {
    return VisualizerModel(
      lastUpdate: lastUpdate ?? this.lastUpdate,
      nodeModelList: nodeModelList ?? this.nodeModelList,
    );
  }

  @override
  List<Object?> get props => <Object?>[lastUpdate, nodeModelList];
}
