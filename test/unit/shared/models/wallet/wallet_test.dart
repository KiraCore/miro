import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart' as miro;
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/wallet_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  // @formatter:off
  String actualMnemonicString =
      'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  miro.Mnemonic actualMnemonic = miro.Mnemonic(value: actualMnemonicString);
  // @formatter:on

  group('Tests of factory constructor Wallet.derive()', () {
    test('Should create wallet keys from derived mnemonic', () async {
      // Act
      Wallet actualWallet = await Wallet.derive(mnemonic: actualMnemonic);

      // Assert
      Wallet expectedWallet = Wallet(
        ecPrivateKey: ECPrivateKey.fromBytes(
          base64Decode('nnN+AtBiwQFyn70Ug6h2Qt/EMMFH6XM7wPDYaFV4Xjw='),
          CurvePoints.generatorSecp256k1,
        ),
        address: CosmosWalletAddress(addressBytes: base64Decode('Q3gyFy2Y5SOn/HSLntM6xykhlkw=')),
      );

      expect(actualWallet, expectedWallet);
    });
    test('Should throw AssertionError, because lastDerivationPathSegment is less than zero', () async {
      expect(
        () => Wallet.derive(mnemonic: actualMnemonic, lastDerivationPathSegment: -1),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
