import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/a_staking_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/staking_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_loading_state.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/staking_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of [StakingDrawerPageCubit] process', () {
    test('Should return [AStakingDrawerPageState] consistent with network response', () async {
      // Arrange
      StakingDrawerPageCubit actualStakingDrawerPageCubit = StakingDrawerPageCubit();

      // Act
      AStakingDrawerPageState actualStakingDrawerPageState = actualStakingDrawerPageCubit.state;

      // Assert
      AStakingDrawerPageState expectedStakingDrawerPageState = const StakingDrawerPageLoadingState();

      TestUtils.printInfo('Should return [StakingDrawerPageLoadingState] as initial [StakingDrawerPageCubit] state');
      expect(actualStakingDrawerPageState, expectedStakingDrawerPageState);

      // ****************************************************************************************

      // Arrange
      WalletAddress validatorWalletAddress = WalletAddress.fromBech32('kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy');

      // Act
      await actualStakingDrawerPageCubit.init(validatorWalletAddress);
      actualStakingDrawerPageState = actualStakingDrawerPageCubit.state;

      // Assert
      expectedStakingDrawerPageState = const StakingDrawerPageErrorState();

      TestUtils.printInfo('Should emit [StakingDrawerPageErrorState] after init() if network is offline');
      expect(actualStakingDrawerPageState, expectedStakingDrawerPageState);

      // ****************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      await actualStakingDrawerPageCubit.init(validatorWalletAddress);
      actualStakingDrawerPageState = actualStakingDrawerPageCubit.state;

      // Assert
      expectedStakingDrawerPageState = StakingDrawerPageLoadedState(
        stakingPoolModel: StakingPoolModel(
          slashed: '0%',
          totalDelegators: 1,
          votingPower: <TokenAmountModel>[
            TokenAmountModel(
              defaultDenominationAmount: Decimal.fromInt(100),
              tokenAliasModel: TestUtils.kexTokenAliasModel,
            ),
          ],
          commission: '10%',
          tokens: <TokenAliasModel>[
            TokenAliasModel.local('frozen'),
            TokenAliasModel.local('ubtc'),
            TestUtils.kexTokenAliasModel,
            TokenAliasModel.local('xeth'),
          ],
        ),
      );

      TestUtils.printInfo('Should return [StakingDrawerPageLoadedState] after init() if network is online');
      expect(actualStakingDrawerPageState, expectedStakingDrawerPageState);
    });
  });
}
