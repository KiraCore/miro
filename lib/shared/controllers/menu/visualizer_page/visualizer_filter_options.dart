import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class VisualizerFilterOptions {
  static List<FilterOptionModel<VisualizerNodeModel>> getFilterOptionModels(List<String> filters) {
    List<FilterOptionModel<VisualizerNodeModel>> filterOptionModels = <FilterOptionModel<VisualizerNodeModel>>[];
    for (String filter in filters) {
      filterOptionModels.add(
        FilterOptionModel<VisualizerNodeModel>(
          title: filter,
          filterOption: FilterOption<VisualizerNodeModel>(
            id: filter,
            filterComparator: (VisualizerNodeModel a) => a.countryLatLongModel.country == filter,
          ),
        ),
      );
    }
    return filterOptionModels;
  }

  static FilterComparator<VisualizerNodeModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (VisualizerNodeModel item) {
      bool monikerMatch = item.moniker.toLowerCase().contains(pattern);
      bool countryCodeMatch = item.countryLatLongModel.country.toLowerCase().contains(pattern);
      return monikerMatch || countryCodeMatch;
    };
  }
}
