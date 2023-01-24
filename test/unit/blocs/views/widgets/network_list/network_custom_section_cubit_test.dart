import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/views/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/specific_blocs/views/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/views/widgets/network_list/network_custom_section_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  NetworkCustomSectionCubit networkCustomSectionCubit = NetworkCustomSectionCubit();

  group('Tests of NetworkCustomSectionCubit process', () {
    test('Should return NetworkCustomSectionState/NetworkModuleState consistent with current action', () async {
      // Act
      NetworkCustomSectionState actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      NetworkCustomSectionState expectedNetworkCustomSectionState = NetworkCustomSectionState();

      TestUtils.printInfo('Should return empty NetworkCustomSectionState as initial NetworkCustomSectionCubit state');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkHealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        checkedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo('Should return custom network as checkedNetworkStatusModel');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo('Should set current checkedNetworkStatusModel as connectedNetworkStatusModel');

      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.checkConnection(TestUtils.customNetworkUnhealthyModel.uri);
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
        checkedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
      );

      TestUtils.printInfo('Should add new checkedNetworkStatusModel if custom network is connected and checked network is different from connected');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      TestUtils.printInfo('Should not change state if new connected network is equal current connected network (network refreshed)');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);

      // ****************************************************************************************

      // Act
      await networkCustomSectionCubit.updateAfterNetworkConnect(
        TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );
      actualNetworkCustomSectionState = networkCustomSectionCubit.state;

      // Assert
      expectedNetworkCustomSectionState = NetworkCustomSectionState(
        connectedNetworkStatusModel: TestUtils.customNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected),
      );

      TestUtils.printInfo('Should remove previous connected network and set new network as connected if new connected network is different from previous');
      expect(actualNetworkCustomSectionState, expectedNetworkCustomSectionState);
    });
  });
}
