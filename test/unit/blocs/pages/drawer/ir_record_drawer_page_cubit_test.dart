import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/a_ir_record_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/ir_record_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loading_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/ir_record_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final IRModel expectedVerifierIRModel = IRModel(
    walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    usernameIRRecordModel: IRRecordModel(
      id: '3',
      key: 'username',
      value: 'somnitear',
      verifiersAddresses: const <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[
        IRVerificationRequestModel(
          requesterWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          recordIds: const <String>['3'],
        )
      ],
    ),
    descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
    socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
    avatarIRRecordModel: const IRRecordModel(
      id: '2',
      key: 'avatar',
      value: 'https://avatars.githubusercontent.com/u/114292385',
      verifiersAddresses: <WalletAddress>[],
      irVerificationRequests: <IRVerificationRequestModel>[],
    ),
    otherIRRecordModelList: <IRRecordModel>[
      IRRecordModel(
        id: '4',
        key: 'github',
        value: 'https://github.com/kiracore',
        verifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        irVerificationRequests: const <IRVerificationRequestModel>[],
      ),
    ],
  );

  group('Tests of [IRRecordDrawerPageCubit] process', () {
    test('Should return AIRRecordDrawerPageState consistent with network response', () async {
      // Arrange
      IRRecordModel actualIrRecordModel = IRRecordModel(
        id: '3',
        key: 'username',
        value: 'somnitear',
        verifiersAddresses: const <WalletAddress>[],
        irVerificationRequests: <IRVerificationRequestModel>[
          IRVerificationRequestModel(
            requesterWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            recordIds: const <String>['3'],
          )
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
        irVerificationModels: <IRVerificationModel>[
          IRVerificationModel(
            verifierIrModel: expectedVerifierIRModel,
            irVerificationRequestStatus: IRVerificationRequestStatus.pending,
          ),
        ],
      );

      TestUtils.printInfo('Should return [IRRecordDrawerPageLoadedState] after init() if network is online');
      expect(actualIrRecordDrawerPageCubit.state, expectedIrRecordDrawerPageState);
    });
  });
}
