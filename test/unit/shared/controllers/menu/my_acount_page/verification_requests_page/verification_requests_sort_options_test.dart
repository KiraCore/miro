import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_sort_options.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/menu/my_acount_page/verification_requests_page/verification_requests_sort_options_test.dart --platform chrome --null-assertions
void main() {
  final IRUserProfileModel irUserProfileModel1 = IRUserProfileModel(
    walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    username: 'somnitear',
    avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
  );

  final IRUserProfileModel irUserProfileModel2 = IRUserProfileModel(
    walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
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

  group('Tests of VerificationRequestsSortOptions.sortByDate', () {
    test('Should return [List of IRInboundVerificationRequestModel] [sorted by DATE] ascending', () {
      // Act
      List<IRInboundVerificationRequestModel> actualListToSort = List<IRInboundVerificationRequestModel>.from(irInboundVerificationRequestModelList);
      List<IRInboundVerificationRequestModel> actualSortedList = VerificationRequestsSortOptions.sortByDate.sort(actualListToSort);

      // Assert
      List<IRInboundVerificationRequestModel> expectedSortedList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel1,
        irInboundVerificationRequestModel2,
        irInboundVerificationRequestModel3,
        irInboundVerificationRequestModel4,
      ];

      expect(actualSortedList, expectedSortedList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] [sorted by DATE] descending', () {
      // Act
      List<IRInboundVerificationRequestModel> actualListToSort = List<IRInboundVerificationRequestModel>.from(irInboundVerificationRequestModelList);
      List<IRInboundVerificationRequestModel> actualSortedList = VerificationRequestsSortOptions.sortByDate.reversed().sort(actualListToSort);

      // Assert
      List<IRInboundVerificationRequestModel> expectedSortedList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel4,
        irInboundVerificationRequestModel3,
        irInboundVerificationRequestModel2,
        irInboundVerificationRequestModel1,
      ];

      expect(actualSortedList, expectedSortedList);
    });
  });

  group('Tests of VerificationRequestsSortOptions.sortByTip', () {
    test('Should return [List of IRInboundVerificationRequestModel] [sorted by TIP] ascending', () {
      // Act
      List<IRInboundVerificationRequestModel> actualListToSort = List<IRInboundVerificationRequestModel>.from(irInboundVerificationRequestModelList);
      List<IRInboundVerificationRequestModel> actualSortedList = VerificationRequestsSortOptions.sortByTip.sort(actualListToSort);

      // Assert
      List<IRInboundVerificationRequestModel> expectedSortedList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel3,
        irInboundVerificationRequestModel4,
        irInboundVerificationRequestModel1,
        irInboundVerificationRequestModel2,
      ];

      expect(actualSortedList, expectedSortedList);
    });

    test('Should return [List of IRInboundVerificationRequestModel] [sorted by TIP] descending', () {
      // Act
      List<IRInboundVerificationRequestModel> actualListToSort = List<IRInboundVerificationRequestModel>.from(irInboundVerificationRequestModelList);
      List<IRInboundVerificationRequestModel> actualSortedList = VerificationRequestsSortOptions.sortByTip.reversed().sort(actualListToSort);

      // Assert
      List<IRInboundVerificationRequestModel> expectedSortedList = <IRInboundVerificationRequestModel>[
        irInboundVerificationRequestModel2,
        irInboundVerificationRequestModel1,
        irInboundVerificationRequestModel4,
        irInboundVerificationRequestModel3,
      ];

      expect(actualSortedList, expectedSortedList);
    });
  });
}
