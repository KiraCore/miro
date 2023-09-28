import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/a_ir_record_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/ir_record_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loading_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/ir_record_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final IRUserProfileModel expectedIrUserProfileModel = IRUserProfileModel(
    walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    username: 'somnitear',
    avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
  );

  group('Tests of [IRRecordDrawerPageCubit] process', () {
    test('Should return AIRRecordDrawerPageState consistent with network response', () async {
      // Arrange
      IRRecordModel actualIrRecordModel = IRRecordModel(
        id: '3',
        key: 'username',
        value: 'somnitear',
        verifiersAddresses: const <WalletAddress>[],
        pendingVerifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
      );
      IRRecordDrawerPageCubit actualIrRecordDrawerPageCubit = IRRecordDrawerPageCubit(irRecordModel: actualIrRecordModel);

      // Act
      AIRRecordDrawerPageState actualIrRecordDrawerPageState = actualIrRecordDrawerPageCubit.state;

      // Assert
      AIRRecordDrawerPageState expectedIrRecordDrawerPageState = const IRRecordDrawerPageLoadingState();

      TestUtils.printInfo('Should emit [IRRecordDrawerPageLoadingState] as a initial state');
      expect(actualIrRecordDrawerPageState, expectedIrRecordDrawerPageState);

      // ************************************************************************************************

      // Act
      await actualIrRecordDrawerPageCubit.init();

      // Assert
      expectedIrRecordDrawerPageState = IRRecordDrawerPageErrorState();

      TestUtils.printInfo('Should emit [IRRecordDrawerPageErrorState] after init() if network is offline');
      expect(actualIrRecordDrawerPageCubit.state, expectedIrRecordDrawerPageState);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      await actualIrRecordDrawerPageCubit.init();

      // Assert
      expectedIrRecordDrawerPageState = IRRecordDrawerPageLoadedState(
        irRecordVerificationRequestModels: <IRRecordVerificationRequestModel>[
          IRRecordVerificationRequestModel(
            verifierIrUserProfileModel: expectedIrUserProfileModel,
            irVerificationRequestStatus: IRVerificationRequestStatus.pending,
          ),
        ],
      );

      TestUtils.printInfo('Should return [IRRecordDrawerPageLoadedState] after init() if network is online');
      expect(actualIrRecordDrawerPageCubit.state, expectedIrRecordDrawerPageState);
    });
  });
}
