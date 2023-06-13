import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/pages/menu/visualizer/a_visualizer_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_error_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_loading_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/visualizer_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/visualizer/country_lat_long_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/menu/visualizer_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of [VisualizerCubit] process', () {
    test('Should return AVisualizerState consistent with network response', () async {
      // Arrange
      globalLocator<NetworkModuleBloc>().add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      VisualizerCubit actualVisualizerCubit = VisualizerCubit();

      // Assert
      AVisualizerState expectedVisualizerState = VisualizerLoadingState();

      TestUtils.printInfo('Should return VisualizerLoadingState as a initial state');
      expect(actualVisualizerCubit.state, expectedVisualizerState);

      // ************************************************************************************************
      // Act
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      expectedVisualizerState = VisualizerErrorState();

      TestUtils.printInfo('Should return VisualizerErrorState if cannot fetch visualizer data');
      expect(actualVisualizerCubit.state, expectedVisualizerState);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

      // Assert
      VisualizerNodeModel actualFirstNodeModel = actualVisualizerCubit.state.visualizerNodeModelList!.first;
      VisualizerNodeModel actualLastNodeModel = actualVisualizerCubit.state.visualizerNodeModelList!.last;
      int actualNodeModelListLength = actualVisualizerCubit.state.visualizerNodeModelList!.length;

      VisualizerNodeModel expectedFirstNodeModel = VisualizerNodeModel(
        peersNumber: 42,
        ip: '62.122.168.232',
        dataCenter: 'Serverel Inc.',
        moniker: 'Mach.Fund',
        address: 'kira16t9fsvddwfvp00wqm060z5z9dj5nf03fnk9fts',
        website: 'https://facebook.com',
        countryLatLongModel: const CountryLatLongModel(latitude: 51, longitude: 9, country: 'Germany'),
      );
      VisualizerNodeModel expectedLastNodeModel = VisualizerNodeModel(
        peersNumber: 63,
        ip: '65.21.198.195',
        dataCenter: 'Hetzner Online GmbH',
        moniker: 'ValidatorBros',
        address: 'kira190lcxzwxrpz769erd65a6a79ea8f3pqee3y6kk',
        countryLatLongModel: const CountryLatLongModel(latitude: 64, longitude: 26, country: 'Finland'),
      );
      int expectedNodeModelListLength = 18;

      TestUtils.printInfo('Should return VisualizerLoadedState');
      expect(actualFirstNodeModel, expectedFirstNodeModel);
      expect(actualLastNodeModel, expectedLastNodeModel);
      expect(actualNodeModelListLength, expectedNodeModelListLength);
    });
  });

  group('Tests of getUniqueCountryCodes() method', () {
    test('Should return list of filters consistent with network response', () async {
      // Arrange
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://offline.kira.network/'));
      VisualizerCubit actualVisualizerCubit = VisualizerCubit();

      // Act
      List<String> actualFilters = actualVisualizerCubit.getUniqueCountries();

      // Assert
      List<String> expectedFilters = <String>[];

      TestUtils.printInfo('Should return [empty list] as initial state');
      expect(actualFilters, expectedFilters);

      // ************************************************************************************************

      // Act
      actualFilters = actualVisualizerCubit.getUniqueCountries();

      TestUtils.printInfo('Should return [empty list] at error state');
      expect(actualFilters, expectedFilters);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      actualFilters = actualVisualizerCubit.getUniqueCountries();

      // Assert
      expectedFilters = <String>['Germany', 'Finland', 'Ukraine', 'Poland', 'United States'];

      TestUtils.printInfo('Should return list of country codes which repeat at least once in the response');
      expect(actualFilters, expectedFilters);
    });
  });
}
