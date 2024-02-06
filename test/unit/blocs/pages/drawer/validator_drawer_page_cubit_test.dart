import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/validator_drawer_page_cubit.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/validator_drawer_page_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

  group('Tests of [ValidatorDrawerPageCubit] process', () {
    test('Should return [AValidatorDrawerPageState] consistent with current action', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);
      ValidatorDrawerPageCubit actualValidatorDrawerPageCubit = ValidatorDrawerPageCubit();

      // Act
      AValidatorDrawerPageState actualValidatorDrawerPageState = actualValidatorDrawerPageCubit.state;

      // Assert
      AValidatorDrawerPageState expectedValidatorDrawerPageState = const ValidatorDrawerPageLoadingState();

      TestUtils.printInfo('Should return [AValidatorDrawerPageLoadingState] as initial [ValidatorDrawerPageCubit] state');
      expect(actualValidatorDrawerPageState, expectedValidatorDrawerPageState);

      // ****************************************************************************************

      // Act
      await actualValidatorDrawerPageCubit.init('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      actualValidatorDrawerPageState = actualValidatorDrawerPageCubit.state;

      // Assert
      expectedValidatorDrawerPageState = ValidatorDrawerPageLoadedState(
        stakingPoolModel: StakingPoolModel(
          commission: '10%',
          slashed: '0%',
          tokens: <TokenAliasModel>[
            TokenAliasModel.local('frozen'),
            TokenAliasModel.local('ubtc'),
            TestUtils.kexTokenAliasModel,
            TokenAliasModel.local('xeth'),
          ],
          votingPower: <TokenAmountModel>[TokenAmountModel(defaultDenominationAmount: Decimal.parse('100'), tokenAliasModel: TestUtils.kexTokenAliasModel)],
          totalDelegators: 1,
        ),
      );

      TestUtils.printInfo('Should return [ValidatorDrawerPageLoadedState] with [FILLED StakingPoolModel] if network [HEALTHY]');
      expect(actualValidatorDrawerPageState, expectedValidatorDrawerPageState);

      // ****************************************************************************************

      // Arrange
      networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      await actualValidatorDrawerPageCubit.init('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');
      await Future<void>.delayed(const Duration(milliseconds: 500));
      actualValidatorDrawerPageState = actualValidatorDrawerPageCubit.state;

      // Assert
      expectedValidatorDrawerPageState = const ValidatorDrawerPageErrorState();

      TestUtils.printInfo('Should return empty [ValidatorDrawerPageErrorState] if network [OFFLINE]');
      expect(actualValidatorDrawerPageState, expectedValidatorDrawerPageState);
    });
  });
}
