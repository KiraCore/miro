import 'package:miro/blocs/pages/menu/visualizer/a_visualizer_state.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';

class VisualizerLoadedState extends AVisualizerState {
  const VisualizerLoadedState({
    required List<VisualizerNodeModel> visualizerNodeModelList,
  }) : super(visualizerNodeModelList: visualizerNodeModelList);
}
