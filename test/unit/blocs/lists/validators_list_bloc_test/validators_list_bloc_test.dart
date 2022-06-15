import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_event/reached_bottom_infinity_list_event.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_state/infinity_list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/add_filter_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/remove_filter_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/sort_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/no_interx_connection_state.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_filter_options.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_sort_options.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/test/mocks/api/api_query_validators.dart' as api_validators_mocks;
import 'package:miro/test/mocks/api/api_status.dart' as api_status_mocks;
import 'package:miro/test/test_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/lists/validators_list_bloc_test/validators_list_bloc_test.dart --platform chrome
Future<void> main() async {
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  final NetworkModel networkModel = NetworkModel(
    name: 'https://online.kira.network',
    url: 'https://online.kira.network',
    status: NetworkHealthStatus.online,
    queryInterxStatus: QueryInterxStatusResp.fromJson(api_status_mocks.apiStatusMock),
    queryValidatorsResp: QueryValidatorsResp.fromJson(api_validators_mocks.apiValidatorsMock),
  );

  ValidatorModel topValidator1 = ValidatorModel(
    top: 1,
    address: 'kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy',
    moniker: 'OneStar',
    validatorStatus: ValidatorStatus.active,
  );
  ValidatorModel topValidator2 = ValidatorModel(
    top: 2,
    address: 'kira1gfqq3kqn7tuhnpph4487d57c00dkptt3hefgkk',
    moniker: 'necrus',
    validatorStatus: ValidatorStatus.waiting,
  );
  ValidatorModel topValidator3 = ValidatorModel(
    top: 3,
    address: 'kira13hrpqkv53t82n2e72kfr3kuvvvr3565p234g3g',
    moniker: 'apexnode',
    validatorStatus: ValidatorStatus.active,
  );

  group('Tests of initial list state', () {
    test('Should return NoInterxConnectionState if interx is not connected', () async {
      // Arrange
      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        isA<NoInterxConnectionState>(),
      );
    });
  });

  group('Tests of fetching list data', () {
    test('Should return InfinityListLoadedState if network is connected and data exists', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator1, topValidator2],
          lastPage: false,
        ),
      );
    });

    test('Should return two pages data after first reach bottom', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(ReachedBottomInfinityListEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator1, topValidator2, topValidator3],
          lastPage: true,
        ),
      );
    });
  });

  group('Tests of list sorting', () {
    test('Should download all pages, sort them by "top" descending and return first page only', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(SortEvent<ValidatorModel>(ValidatorsSortOptions.sortByTop.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator3, topValidator2],
          lastPage: false,
        ),
      );
    });

    test(
        'Should download all pages, sort them by "top" descending and after reached bottom, should return first two pages',
        () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      validatorsListBloc.add(SortEvent<ValidatorModel>(ValidatorsSortOptions.sortByTop.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));
      validatorsListBloc.add(ReachedBottomInfinityListEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator3, topValidator2, topValidator1],
          lastPage: true,
        ),
      );
    });

    test('Should remove active sort option and return sorted list by default sort option', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(SortEvent<ValidatorModel>(ValidatorsSortOptions.sortByTop.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));
      validatorsListBloc.add(SortEvent<ValidatorModel>(null));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator1, topValidator2],
          lastPage: false,
        ),
      );
    });
  });

  group('Tests of list filtering', () {
    test('Should download all pages, filter them by "Active Validators" and return first page only', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(AddFilterEvent<ValidatorModel>(ValidatorsFilterOptions.filterByActiveValidators));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator1, topValidator3],
          lastPage: false,
        ),
      );
    });

    test(
        'Should download all pages, filter them by "Active Validators", sort by "top" descending and return first page only',
        () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(AddFilterEvent<ValidatorModel>(ValidatorsFilterOptions.filterByActiveValidators));
      await Future<void>.delayed(const Duration(milliseconds: 600));
      validatorsListBloc.add(SortEvent<ValidatorModel>(ValidatorsSortOptions.sortByTop.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator3, topValidator1],
          lastPage: false,
        ),
      );
    });

    test('Should remove selected filter and return list filtered by default', () async {
      // Arrange
      globalLocator<NetworkProvider>()
        ..state = ConnectingNetworkState(networkModel)
        ..handleEvent(SetUpNetworkEvent(networkModel));

      ValidatorsListBloc validatorsListBloc = ValidatorsListBloc.init(
        queryValidatorsService: globalLocator<QueryValidatorsService>(),
        networkProvider: globalLocator<NetworkProvider>(),
        pageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      validatorsListBloc.add(AddFilterEvent<ValidatorModel>(ValidatorsFilterOptions.filterByActiveValidators));
      await Future<void>.delayed(const Duration(milliseconds: 600));
      validatorsListBloc.add(RemoveFilterEvent<ValidatorModel>(ValidatorsFilterOptions.filterByActiveValidators));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(
        validatorsListBloc.state,
        InfinityListLoadedState<ValidatorModel>(
          data: <ValidatorModel>[topValidator1, topValidator2],
          lastPage: false,
        ),
      );
    });
  });
}
