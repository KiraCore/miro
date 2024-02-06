import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/identity_registrar/ir_inbound_verification_request_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of IrInboundVerification.fillTokenAliases()', () {
    test('Should [ValidatorStakingModel] with filled token aliases in [tipTokenAmountModel]', () {
      // Arrange
      IRInboundVerificationRequestModel rawActualIrInboundVerificationRequestModel = IRInboundVerificationRequestModel(
        id: '1',
        dateTime: DateTime(2020, 1, 1),
        requesterIrUserProfileModel: IRUserProfileModel(
          walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          username: 'somnitear',
          avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
        ),
        records: <String, String>{'flower': 'rose'},
        tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TokenAliasModel.local('ukex'), defaultDenominationAmount: Decimal.fromInt(500)),
      );

      // Act
      IRInboundVerificationRequestModel actualIrInboundVerificationRequestModel =
          rawActualIrInboundVerificationRequestModel.fillTokenAliases(TestUtils.tokenAliasModelList);

      // Assert
      IRInboundVerificationRequestModel expectedIrInboundVerificationRequestModel = IRInboundVerificationRequestModel(
        id: '1',
        dateTime: DateTime(2020, 1, 1),
        requesterIrUserProfileModel: IRUserProfileModel(
          walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          username: 'somnitear',
          avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
        ),
        records: <String, String>{'flower': 'rose'},
        tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(500)),
      );

      expect(actualIrInboundVerificationRequestModel, expectedIrInboundVerificationRequestModel);
    });
  });
}
