import 'package:flutter/material.dart';
import 'package:miro/blocs/pages/menu/visualizer/visualizer_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/visualizer_page/visualizer_filter_options.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown.dart';

class VisualizerFilterDropdown extends StatelessWidget {
  final double width;

  const VisualizerFilterDropdown({
    this.width = 100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizerCubit visualizerCubit = globalLocator<VisualizerCubit>();
    List<String> filters = visualizerCubit.getUniqueCountries();

    return FilterDropdown<VisualizerNodeModel>(
      width: width,
      title: S.of(context).validatorsTableStatus,
      filterOptionModels: VisualizerFilterOptions.getFilterOptionModels(filters),
      scrollableBool: true,
    );
  }
}
