import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

void main() {
  // @formatter:off

  // Actual Values for tests
  String actualMnemonicString =
      'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);

  const Map<String, dynamic> actualKeyFilePublicJSON = <String, dynamic>{
    'publicKey': '02e6a3f3cc4e8eb5f2ff127f17f01a515a255701373c5e499a03470a20832e6f7c',
    'address': '437832172d98e523a7fc748b9ed33ac72921964c',
    'bech32Address': 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3',
    'walletDetails': <String, dynamic>{
      'bech32Hrp': 'kira',
      'name': 'Kira Network',
      'iconUrl': null,
      'defaultTokenName': null
    }
  };

  const Map<String, dynamic> actualKeyFilePrivateJSON = <String, dynamic>{
    'privateKey': '9e737e02d062c101729fbd1483a87642dfc430c147e9733bc0f0d86855785e3c',
  };

  // Expected Values of tests
  List<int> expectedPublicKey = <int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124];
  List<int> expectedPrivateKey = <int>[158, 115, 126, 2, 208, 98, 193, 1, 114, 159, 189, 20, 131, 168, 118, 66, 223, 196, 48, 193, 71, 233, 115, 59, 192, 240, 216, 104, 85, 120, 94, 60];
  List<int> expectedAddress = <int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76];

  String expectedBech32address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
  String expectedBech32PublicKey = 'kirapub1addwnpepqtn28u7vf68ttuhlzfl30uq629dz24cpxu79ujv6qdrs5gyr9ehhc04qw2f';

  Wallet expectedWallet = Wallet(
    privateKey: Uint8List.fromList(expectedPrivateKey),
    publicKey: Uint8List.fromList(expectedPublicKey),
    address: Uint8List.fromList(expectedAddress),
    walletDetails: Wallet.defaultWalletDetails,
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
        actualWallet.address,
        expectedAddress,
      );
    });

    test('Should create valid privateKey from given mnemonic', () async {
      expect(
        actualWallet.privateKey,
        expectedPrivateKey,
      );
    });

    test('Should create valid publicKey from given mnemonic', () async {
      expect(
        actualWallet.publicKey,
        expectedPublicKey,
      );
    });

    test('Should create valid bech32 address from given mnemonic', () async {
      expect(
        actualWallet.bech32Address,
        expectedBech32address,
      );
    });

    test('Should create valid bech32 address from given mnemonic', () async {
      expect(
        actualWallet.bech32PublicKey,
        expectedBech32PublicKey,
      );
    });

    test('Should build bech32 in predefined format ex. keyfile_kiraXXXX_XXXX', () async {
      expect(
        actualWallet.bech32Shortcut,
        'kira1gdu_l7u3',
      );
    });
  });
}
