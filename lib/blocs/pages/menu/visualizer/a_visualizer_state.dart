import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';

abstract class AVisualizerState extends Equatable {
  final List<VisualizerNodeModel>? visualizerNodeModelList;

  const AVisualizerState({
    this.visualizerNodeModelList,
  });

  @override
  List<Object?> get props => <Object?>[visualizerNodeModelList];
}
