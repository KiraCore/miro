import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/validator_drawer_page_cubit.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/validator_drawer_page_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

  group('Tests of [StakingPoolDrawerCubit] process', () {
    test('Should return [AStakingPoolDrawerState] consistent with current action', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);
      ValidatorDrawerPageCubit actualStakingPoolDrawerCubit = ValidatorDrawerPageCubit();

      // Act
      AValidatorDrawerPageState actualStakingPoolDrawerState = actualStakingPoolDrawerCubit.state;

      // Assert
      AValidatorDrawerPageState expectedStakingPoolDrawerState = const ValidatorDrawerPageLoadingState();

      TestUtils.printInfo('Should return [StakingPoolDrawerLoadingState] as initial [StakingPoolDrawerCubit] state');
      expect(actualStakingPoolDrawerState, expectedStakingPoolDrawerState);

      // ****************************************************************************************

      // Act

      await actualStakingPoolDrawerCubit.loadStakingPoolByAddress('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      actualStakingPoolDrawerState = actualStakingPoolDrawerCubit.state;

      // Assert
      expectedStakingPoolDrawerState = ValidatorDrawerPageLoadedState(
        stakingPoolModel: StakingPoolModel(
          commission: '10%',
          slashed: '0%',
          tokens: const <String>['frozen', 'ubtc', 'ukex', 'xeth'],
          votingPower: <TokenAmountModel>[TokenAmountModel(lowestDenominationAmount: Decimal.parse('100'), tokenAliasModel: TokenAliasModel.local('ukex'))],
          id: 1,
          totalDelegators: 1,
        ),
        irModel: IRModel(
          walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          usernameIRRecordModel: IRRecordModel(
            id: '3',
            key: 'username',
            value: 'somnitear',
            verifiersAddresses: const <WalletAddress>[],
            pendingVerifiersAddresses: <WalletAddress>[
              WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            ],
          ),
          descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
          socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social_media'),
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

      TestUtils.printInfo('Should return [StakingPoolDrawerLoadedState] with [FILLED StakingPoolModel] and [FILLED IRModel] if network [HEALTHY]');
      expect(actualStakingPoolDrawerState, expectedStakingPoolDrawerState);

      // ****************************************************************************************

      // Arrange
      networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      await actualStakingPoolDrawerCubit.loadStakingPoolByAddress('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      actualStakingPoolDrawerState = actualStakingPoolDrawerCubit.state;

      // Assert
      expectedStakingPoolDrawerState = ValidatorDrawerPageLoadedState(
        stakingPoolModel: null,
        irModel: IRModel.empty(walletAddress: TestUtils.wallet.address),
      );

      TestUtils.printInfo('Should return empty [StakingPoolDrawerLoadedState] with [EMPTY StakingPoolModel] and [EMPTY IRModel] if network [OFFLINE]');
      expect(actualStakingPoolDrawerState, expectedStakingPoolDrawerState);
    });
  });
}
