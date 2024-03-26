import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/wallet_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  // @formatter:off
  // Actual Values for tests
  const String actualMnemonicString =
      'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);

  const Map<String, dynamic> actualKeyFilePublicJSON = <String, dynamic>{
    'version': '1.0.1',
    'bech32Address': 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3',
  };

  const Map<String, dynamic> actualKeyFilePrivateJSON = <String, dynamic>{
    'privateKey': '9e737e02d062c101729fbd1483a87642dfc430c147e9733bc0f0d86855785e3c',
  };

  // Expected Values of tests
  List<int> expectedPrivateKey = <int>[158, 115, 126, 2, 208, 98, 193, 1, 114, 159, 189, 20, 131, 168, 118, 66, 223, 196, 48, 193, 71, 233, 115, 59, 192, 240, 216, 104, 85, 120, 94, 60];
  List<int> expectedAddress = <int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76];

  String expectedBech32address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

  Wallet expectedWallet = Wallet(
    privateKey: Uint8List.fromList(expectedPrivateKey),
    address: WalletAddress(addressBytes: Uint8List.fromList(expectedAddress)),
  );
  // @formatter:on

  group('Tests of factory constructor Wallet.derive()', () {
    test('Should create wallet keys from derived mnemonic', () async {
      expect(
        actualWallet,
        expectedWallet,
      );
    });
    test('Should throw FormatException, because lastDerivationPathSegment is less than zero', () async {
      expect(
        () => Wallet.derive(mnemonic: actualMnemonic, lastDerivationPathSegment: '-1'),
        throwsA(isA<FormatException>()),
      );
    });
    test('Should throw FormatException, because lastDerivationPathSegment is not a number', () async {
      expect(
        () => Wallet.derive(mnemonic: actualMnemonic, lastDerivationPathSegment: 'abc'),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('Tests of factory constructor Wallet.fromKeyFileData()', () {
    test('Should create wallet keys from derived private and public json', () async {
      expect(
        Wallet.fromKeyFileData(actualKeyFilePublicJSON, actualKeyFilePrivateJSON),
        expectedWallet,
      );
    });
  });

  group('Test of wallet class arguments and methods', () {
    test('Should create valid wallet address from given mnemonic', () async {
      expect(
        actualWallet.address.addressBytes,
        expectedAddress,
      );
    });

    test('Should create valid privateKey from given mnemonic', () async {
      expect(
        actualWallet.privateKey,
        expectedPrivateKey,
      );
    });

    test('Should create valid bech32 address from given mnemonic', () async {
      expect(
        actualWallet.address.bech32Address,
        expectedBech32address,
      );
    });

    test('Should return short bech32 address ex. keyfile_kiraXXXX_XXXX', () async {
      expect(
        actualWallet.address.buildBech32AddressShort(delimiter: '...'),
        'kira1gdu...l7u3',
      );
    });
  });
}
