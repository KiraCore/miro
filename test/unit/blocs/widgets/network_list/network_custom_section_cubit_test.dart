import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/network_list/network_custom_section_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  NetworkCustomSectionCubit networkCustomSectionCubit = NetworkCustomSectionCubit();

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
      networkCustomSectionCubit.resetSwitchValueWhenConnected();
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkHealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        checkedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        expandedBool: true,
      );

      TestUtils.printInfo('Should return state with [custom network] as [checkedNetworkStatusModel] and [true] value of [expandedBool], assumed drawer open');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;
      networkCustomSectionCubit.resetSwitchValueWhenConnected();

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        expandedBool: true,
      );

      TestUtils.printInfo('Should set current [checkedNetworkStatusModel] as [connectedNetworkStatusModel] and keep the [true] value of [expandedBool], assumed drawer closed');

      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkUnhealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        checkedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        expandedBool: true,
      );

      TestUtils.printInfo(
          'Should add [new checkedNetworkStatusModel] and keep the [true] value of [expandedBool] if custom network is connected and checked network is different from connected');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      TestUtils.printInfo('Should [not change state] if new connected network is equal current connected network (network refreshed)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      networkCustomSectionCubit.updateSwitchValue(expandedBool: false);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        checkedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
        expandedBool: false,
      );

      TestUtils.printInfo('Should [not change network state] and should set [false] value of [expandedBool] after using the switch');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        lastConnectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        expandedBool: false,
      );

      TestUtils.printInfo(
          'Should set previous [connected network] as [lastConnectedNetworkStatusModel], set [new network] as [connectedNetworkStatusModel] and keep the [false] value of [expandedBool]');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);
    });
  });
}
