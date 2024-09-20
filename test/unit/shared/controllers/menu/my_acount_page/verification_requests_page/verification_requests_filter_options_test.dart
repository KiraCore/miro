import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_filter_options.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/menu/my_acount_page/verification_requests_page/verification_requests_filter_options_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  final IRUserProfileModel irUserProfileModel1 = IRUserProfileModel(
    walletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    username: 'somnitear',
    avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
  );

  final IRUserProfileModel irUserProfileModel2 = IRUserProfileModel(
    walletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    username: 'marioslaw',
    avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
  );

  final IRInboundVerificationRequestModel irInboundVerificationRequestModel1 = IRInboundVerificationRequestModel(
    id: '1',
    dateTime: DateTime(2020, 1, 1),
    requesterIrUserProfileModel: irUserProfileModel1,
    records: <String, String>{'flower': 'rose'},
    tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(500)),
  );

  final IRInboundVerificationRequestModel irInboundVerificationRequestModel2 = IRInboundVerificationRequestModel(
    id: '2',
    dateTime: DateTime(2021, 1, 1),
    requesterIrUserProfileModel: irUserProfileModel2,
    records: <String, String>{'username': 'miroman123'},
    tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000)),
  );

  final IRInboundVerificationRequestModel irInboundVerificationRequestModel3 = IRInboundVerificationRequestModel(
    id: '3',
    dateTime: DateTime(2022, 1, 1),
    requesterIrUserProfileModel: irUserProfileModel1,
    records: <String, String>{'id': '4', 'favourite_color': 'green'},
    tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100)),
  );

  final IRInboundVerificationRequestModel irInboundVerificationRequestModel4 = IRInboundVerificationRequestModel(
    id: '4',
    dateTime: DateTime(2023, 1, 1),
    requesterIrUserProfileModel: irUserProfileModel2,
    records: <String, String>{'favourite_color': 'blue'},
    tipTokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(400)),
  );

  final List<IRInboundVerificationRequestModel> irInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
    irInboundVerificationRequestModel1,
    irInboundVerificationRequestModel2,
    irInboundVerificationRequestModel3,
    irInboundVerificationRequestModel4,
  ];

  group('Tests of VerificationRequestsFilterOptions.search()', () {
    test('Should return [List of IRInboundVerificationRequestModel] with tip equal "500ukex"', () {
      // Arrange
      FilterComparator<IRInboundVerificationRequestModel> filterComparator = VerificationRequestsFilterOptions.search('500 ukex');

      // Act
      List<IRInboundVerificationRequestModel> actualIrInboundVerificationRequestModelList =
          irInboundVerificationRequestModelList.where(filterComparator).toList();

      // Assert
      List<IRInboundVerificationRequestModel> expectedIrInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel1,
      ];

      expect(actualIrInboundVerificationRequestModelList, expectedIrInboundVerificationRequestModelList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] with address equal "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx"', () {
      // Arrange
      FilterComparator<IRInboundVerificationRequestModel> filterComparator = VerificationRequestsFilterOptions.search('kira143');

      // Act
      List<IRInboundVerificationRequestModel> actualIrInboundVerificationRequestModelList =
          irInboundVerificationRequestModelList.where(filterComparator).toList();

      // Assert
      List<IRInboundVerificationRequestModel> expectedIrInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel1,
        irInboundVerificationRequestModel3,
      ];

      expect(actualIrInboundVerificationRequestModelList, expectedIrInboundVerificationRequestModelList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] with username equal "somnitear"', () {
      // Arrange
      FilterComparator<IRInboundVerificationRequestModel> filterComparator = VerificationRequestsFilterOptions.search('somn');

      // Act
      List<IRInboundVerificationRequestModel> actualIrInboundVerificationRequestModelList =
          irInboundVerificationRequestModelList.where(filterComparator).toList();

      // Assert
      List<IRInboundVerificationRequestModel> expectedIrInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel1,
        irInboundVerificationRequestModel3,
      ];

      expect(actualIrInboundVerificationRequestModelList, expectedIrInboundVerificationRequestModelList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] with key equal "favourite_color"', () {
      // Arrange
      FilterComparator<IRInboundVerificationRequestModel> filterComparator = VerificationRequestsFilterOptions.search('favourite_color');

      // Act
      List<IRInboundVerificationRequestModel> actualIrInboundVerificationRequestModelList =
          irInboundVerificationRequestModelList.where(filterComparator).toList();

      // Assert
      List<IRInboundVerificationRequestModel> expectedIrInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel3,
        irInboundVerificationRequestModel4,
      ];
      expect(actualIrInboundVerificationRequestModelList, expectedIrInboundVerificationRequestModelList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] with value equal "blue"', () {
      // Arrange
      FilterComparator<IRInboundVerificationRequestModel> filterComparator = VerificationRequestsFilterOptions.search('blue');

      // Act
      List<IRInboundVerificationRequestModel> actualIrInboundVerificationRequestModelList =
          irInboundVerificationRequestModelList.where(filterComparator).toList();

      // Assert
      List<IRInboundVerificationRequestModel> expectedIrInboundVerificationRequestModelList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel4,
      ];

      expect(actualIrInboundVerificationRequestModelList, expectedIrInboundVerificationRequestModelList);
    });
  });
}
