import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/network_list/network_custom_section_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  NetworkCustomSectionCubit networkCustomSectionCubit = NetworkCustomSectionCubit();

  final NetworkOfflineModel uriTypoNetworkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.networktypo'),
  );

  final NetworkOfflineModel wrongParamsCustomNetworkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network/wrong?params=0'),
  );

  group('Tests of NetworkCustomSectionCubit process', () {
    test('Should return NetworkCustomSectionState/NetworkModuleState consistent with current action', () async {
      // Act
      NetworkCustomSectionState actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      NetworkCustomSectionState expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: false,
      );

      TestUtils.printInfo('Should return state with [empty network] and [false] value of [expandedBool] as initial NetworkCustomSectionCubit state');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(uriTypoNetworkOfflineModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        checkedNetworkStatusModel: uriTypoNetworkOfflineModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo(
          'Should return state with [offline custom network] as [checkedNetworkStatusModel] and keep [true] value of [expandedBool] (cannot connect because of typo in uri)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      networkCustomSectionCubit.resetSwitchValueWhenConnected();
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkHealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        checkedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo(
          'Should return state with [healthy custom network] as [checkedNetworkStatusModel] and [true] value of [expandedBool], assumed drawer open (Network Drawer Page used)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateNetworks(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;
      networkCustomSectionCubit.resetSwitchValueWhenConnected();

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo(
          'Should set current [checkedNetworkStatusModel] as [connectedNetworkStatusModel], clear [checkedNetworkStatusModel] and keep [true] value of [expandedBool], assumed drawer closed (Network List Page used)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(wrongParamsCustomNetworkOfflineModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        checkedNetworkStatusModel: wrongParamsCustomNetworkOfflineModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo(
          'Should maintain [healthy custom network] as [connectedNetworkStatusModel], add [offline custom network] as [checkedNetworkStatusModel] and keep [true] value of [expandedBool] (cannot connect because of wrong params)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkUnhealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        checkedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo(
          'Should maintain [healthy custom network] as [connectedNetworkStatusModel], add [unhealthy custom network] as [checkedNetworkStatusModel] and keep [true] value of [expandedBool] (custom network is connected and checked network is different from connected)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateNetworks(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      TestUtils.printInfo('Should [not change state] if new connected network is equal current connected network (network refreshed)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      networkCustomSectionCubit.updateSwitchValue(expandedBool: false);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: false,
        checkedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo('Should [not change network state] and should set [false] value of [expandedBool] after using the switch');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateNetworks(
        TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: false,
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        lastConnectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo(
          'Should set previous [connected network] as [lastConnectedNetworkStatusModel], set [new network] as [connectedNetworkStatusModel], clear [checkedNetworkStatusModel] and keep [false] value of [expandedBool]');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkUnhealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: false,
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        lastConnectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo('Should [not change state] if checked network is already present in NetworkCustomSectionState');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkHealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        checkedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        expandedBool: true,
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        lastConnectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo(
          'Should return state with [healthy custom network] as [checkedNetworkStatusModel], not change state of [lastConnectedNetworkStatusModel] and [connectedNetworkStatusModel] and return [true] value of [expandedBool]');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.refreshNetworks();
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        expandedBool: true,
        checkedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        lastConnectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo('Should [not change state] as network refreshed');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);
    });
  });
}
