import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/visualizer_page/visualizer_filter_options.dart';
import 'package:miro/shared/models/visualizer/country_lat_long_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

void main() {
  List<VisualizerNodeModel> nodeModelList = <VisualizerNodeModel>[
    VisualizerNodeModel(
        peersNumber: 1,
        ip: '1.1.1.1',
        dataCenter: 'Apple',
        moniker: 'apple5',
        address: '0x6',
        countryLatLongModel: const CountryLatLongModel(latitude: 1, longitude: 1, country: 'Finland')),
    VisualizerNodeModel(
        peersNumber: 2,
        ip: '2.2.2.2',
        dataCenter: 'Banana',
        moniker: 'banana4',
        address: '0x5',
        countryLatLongModel: const CountryLatLongModel(latitude: 2, longitude: 2, country: 'Finland')),
    VisualizerNodeModel(
        peersNumber: 3,
        ip: '3.3.3.3',
        dataCenter: 'Coconut',
        moniker: 'coconut3',
        address: '0x4',
        countryLatLongModel: const CountryLatLongModel(latitude: 3, longitude: 3, country: 'Finland')),
    VisualizerNodeModel(
        peersNumber: 4,
        ip: '4.4.4.4',
        dataCenter: 'Grape',
        moniker: 'grape2',
        address: '0x3',
        countryLatLongModel: const CountryLatLongModel(latitude: 4, longitude: 4, country: 'Poland')),
    VisualizerNodeModel(
        peersNumber: 5,
        ip: '5.5.5.5',
        dataCenter: 'Huckleberry',
        moniker: 'huckleberry3',
        address: '0x2',
        countryLatLongModel: const CountryLatLongModel(latitude: 5, longitude: 5, country: 'Poland')),
    VisualizerNodeModel(
        peersNumber: 6,
        ip: '6.6.6.6',
        dataCenter: 'Ice',
        moniker: 'ice4',
        address: '0x1',
        countryLatLongModel: const CountryLatLongModel(latitude: 6, longitude: 6, country: 'Croatia')),
  ];

  List<FilterOptionModel<VisualizerNodeModel>> visualizerFilterOptions = <FilterOptionModel<VisualizerNodeModel>>[
    FilterOptionModel<VisualizerNodeModel>(
        title: 'Finland',
        filterOption: FilterOption<VisualizerNodeModel>(
          id: 'Finland',
          filterComparator: (VisualizerNodeModel a) => a.countryLatLongModel.country == 'Finland',
        )),
    FilterOptionModel<VisualizerNodeModel>(
        title: 'Poland',
        filterOption: FilterOption<VisualizerNodeModel>(
          id: 'Poland',
          filterComparator: (VisualizerNodeModel a) => a.countryLatLongModel.country == 'Poland',
        )),
    FilterOptionModel<VisualizerNodeModel>(
        title: 'Croatia',
        filterOption: FilterOption<VisualizerNodeModel>(
          id: 'Croatia',
          filterComparator: (VisualizerNodeModel a) => a.countryLatLongModel.country == 'Croatia',
        )),
  ];

  List<String> uniqueCountries = <String>['Finland', 'Poland', 'Croatia'];

  group('Tests of getFilterOptionModels()', () {
    test('Should return option models based on unique countries', () {
      // Act
      List<FilterOptionModel<VisualizerNodeModel>> actualFilterOptionModels = VisualizerFilterOptions.getFilterOptionModels(uniqueCountries);

      // Assert
      List<FilterOptionModel<VisualizerNodeModel>> expectedFilterOptionModels = visualizerFilterOptions;
      expect(actualFilterOptionModels, expectedFilterOptionModels);
    });
  });

  group('Tests of filtering by country name', () {
    test('Should return only nodes from Poland (matching selected filterComparator)', () {
      // Arrange
      bool filterComparator(VisualizerNodeModel a) => a.countryLatLongModel.country == 'Croatia';
      // Act
      List<VisualizerNodeModel> actualNodeModelList = nodeModelList.where(filterComparator).toList();

      // Assert
      List<VisualizerNodeModel> expectedNodeModelList = <VisualizerNodeModel>[
        VisualizerNodeModel(
            peersNumber: 6,
            ip: '6.6.6.6',
            dataCenter: 'Ice',
            moniker: 'ice4',
            address: '0x1',
            countryLatLongModel: const CountryLatLongModel(latitude: 6, longitude: 6, country: 'Croatia')),
      ];

      expect(actualNodeModelList, expectedNodeModelList);
    });
  });

  group('Tests of search method', () {
    test('Should return only nodes matching "apple" search', () {
      // Arrange
      FilterComparator<VisualizerNodeModel> filterComparator = VisualizerFilterOptions.search('apple');

      // Act
      List<VisualizerNodeModel> actualNodeModelList = nodeModelList.where(filterComparator).toList();

      // Assert
      List<VisualizerNodeModel> expectedNodeModelList = <VisualizerNodeModel>[
        VisualizerNodeModel(
            peersNumber: 1,
            ip: '1.1.1.1',
            dataCenter: 'Apple',
            moniker: 'apple5',
            address: '0x6',
            countryLatLongModel: const CountryLatLongModel(latitude: 1, longitude: 1, country: 'Finland')),
      ];

      expect(actualNodeModelList, expectedNodeModelList);
    });

    test('Should return only nodes matching "apple" search', () {
      // Arrange
      FilterComparator<VisualizerNodeModel> filterComparator = VisualizerFilterOptions.search('poland');

      // Act
      List<VisualizerNodeModel> actualNodeModelList = nodeModelList.where(filterComparator).toList();

      // Assert
      List<VisualizerNodeModel> expectedNodeModelList = <VisualizerNodeModel>[
        VisualizerNodeModel(
            peersNumber: 4,
            ip: '4.4.4.4',
            dataCenter: 'Grape',
            moniker: 'grape2',
            address: '0x3',
            countryLatLongModel: const CountryLatLongModel(latitude: 4, longitude: 4, country: 'Poland')),
        VisualizerNodeModel(
            peersNumber: 5,
            ip: '5.5.5.5',
            dataCenter: 'Huckleberry',
            moniker: 'huckleberry3',
            address: '0x2',
            countryLatLongModel: const CountryLatLongModel(latitude: 5, longitude: 5, country: 'Poland')),
      ];

      expect(actualNodeModelList, expectedNodeModelList);
    });
  });
}
