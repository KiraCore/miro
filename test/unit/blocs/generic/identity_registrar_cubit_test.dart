import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loaded_state.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/identity_registrar_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

  group('Tests of [IdentityRegistrarCubit] process', () {
    test('Should return states assigned to specific actions ', () async {
      // Arrange
      IdentityRegistrarCubit actualIdentityRegistrarCubit = IdentityRegistrarCubit();

      // Act
      AIdentityRegistrarState actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      AIdentityRegistrarState expectedIdentityRegistrarState = const IdentityRegistrarLoadingState();

      TestUtils.printInfo('Should return [IdentityRegistrarLoadingState] as initial state of [IdentityRegistrarCubit]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // ************************************************************************************************

      // Act
      await actualIdentityRegistrarCubit.refresh();
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      expectedIdentityRegistrarState = const IdentityRegistrarLoadingState();

      TestUtils.printInfo('Should return [IdentityRegistrarLoadingState] if [WalletAddress NOT exists] and [network DISCONNECTED]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // ************************************************************************************************

      // Act
      await actualIdentityRegistrarCubit.setWalletAddress(TestUtils.wallet.address);
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      expectedIdentityRegistrarState = IdentityRegistrarLoadedState(
        irModel: IRModel.empty(walletAddress: TestUtils.wallet.address),
      );

      TestUtils.printInfo('Should return [IdentityRegistrarLoadedState] with [EMPTY IRModel] if [WalletAddress exists] but [network DISCONNECTED]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // ************************************************************************************************

      // Act
      await actualIdentityRegistrarCubit.refresh();
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      TestUtils.printInfo(
          'Should return [IdentityRegistrarLoadedState] with [EMPTY IRModel] if [WalletAddress exists] but [network DISCONNECTED] and [IdentityRegistrarCubit refreshed]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // ************************************************************************************************

      // Act
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(TestUtils.networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await actualIdentityRegistrarCubit.refresh();
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      expectedIdentityRegistrarState = IdentityRegistrarLoadedState(
        irModel: IRModel(
          walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          usernameIRRecordModel: IRRecordModel(
            id: '3',
            key: 'username',
            value: 'somnitear',
            verifiersAddresses: const <WalletAddress>[],
            pendingVerifiersAddresses: <WalletAddress>[
              WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            ],
          ),
          descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
          socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
          avatarIRRecordModel: const IRRecordModel(
            id: '2',
            key: 'avatar',
            value: 'https://avatars.githubusercontent.com/u/114292385',
            verifiersAddresses: <WalletAddress>[],
            pendingVerifiersAddresses: <WalletAddress>[],
          ),
          otherIRRecordModelList: <IRRecordModel>[
            IRRecordModel(
              id: '4',
              key: 'github',
              value: 'https://github.com/kiracore',
              verifiersAddresses: <WalletAddress>[
                WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              ],
              pendingVerifiersAddresses: const <WalletAddress>[],
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should return [IdentityRegistrarLoadedState] with [FILLED IRModel] if [WalletAddress exists] and [network CONNECTED]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // Act
      await actualIdentityRegistrarCubit.setWalletAddress(null);
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      expectedIdentityRegistrarState = const IdentityRegistrarLoadingState();

      TestUtils.printInfo('Should return [IdentityRegistrarLoadingState] if [WalletAddress NOT exists] and [network CONNECTED]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);

      // ************************************************************************************************

      // Act
      await actualIdentityRegistrarCubit.refresh();
      actualIdentityRegistrarState = actualIdentityRegistrarCubit.state;

      // Assert
      TestUtils.printInfo(
          'Should return [IdentityRegistrarLoadingState] if [WalletAddress NOT exists] and [network CONNECTED] and [IdentityRegistrarCubit refreshed]');
      expect(actualIdentityRegistrarState, expectedIdentityRegistrarState);
    });
  });
}
