import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/exceptions/invalid_keyfile_exception.dart';
import 'package:miro/shared/exceptions/invalid_password_exception.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/keyfile_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  // @formatter:off
  const String keyFileJSONString = '{\n'
      '  "bech32Address": "kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3",\n'
      '  "version": "1.0.1",\n'
      '  "secretData": "aUDAzfuGC1fB8ACYylYy5Fdqj2upwotYNwuBrb7koYUxmhJaRA8jn8qLXWbFbjbQ/q2mIBtJW5O3clFog+GM2DxiR/1baD00eVOIoZ1Q3IkVcxOSJlYTprV5NsGEQ5mOwjFX3fIHHpqUY0CGCMG7+NBmDPQ="\n'
      '}';

  // Actual Values for tests
  const String actualMnemonicString = 'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  const String actualPassword = 'kiraPassword';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);
  final KeyFile actualKeyfile = KeyFile(wallet: actualWallet, version: KeyFile.latestVersion);
  
  // Expected Values of tests
  // const WalletDetails expectedWalletDetails = Wallet.defaultWalletDetails;
  final Uint8List expectedAddressBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
  final WalletAddress expectedAddress = WalletAddress(addressBytes: expectedAddressBytes);

  final Uint8List expectedPrivateKey = Uint8List.fromList(<int>[158, 115, 126, 2, 208, 98, 193, 1, 114, 159, 189, 20, 131, 168, 118, 66, 223, 196, 48, 193, 71, 233, 115, 59, 192, 240, 216, 104, 85, 120, 94, 60]);
  final Wallet expectedWallet = Wallet(address: expectedAddress, privateKey: expectedPrivateKey);
  const String expectedVersion = KeyFile.latestVersion;
  final KeyFile expectedKeyFile = KeyFile(wallet: expectedWallet, version: expectedVersion);
  const String expectedKeyFileName = 'keyfile_kira1gdu_l7u3.json';
  // @formatter:on

  group('Tests of method encode()', () {
    // Because AES256.encode() always gives random String we cannot match the hardcoded expected result.
    // That`s why we check whether it is possible to encode and decode KeyFile
    test('Should encode() secret data, build valid JSON file and check it via decode() JSON back to KeyFile', () async {
      String encodedKeyFile = actualKeyfile.encode(actualPassword);
      expect(
        KeyFile.decode(encodedKeyFile, actualPassword),
        actualKeyfile,
      );
    });
  });

  group('Tests of factory constructor Keyfile.decode()', () {
    test('Should parse JSON data and decode secret data', () async {
      expect(
        KeyFile.decode(keyFileJSONString, actualPassword),
        expectedKeyFile,
      );
    });

    test('Should build filename in format ex. keyfile_kiraXXXX_XXXX', () async {
      expect(
        KeyFile.decode(keyFileJSONString, actualPassword).fileName,
        expectedKeyFileName,
      );
    });

    test('Should throw FormatException for invalid String data in keyFileJSON', () async {
      String actualInvalidKeyFileJSONString = 'invalid keyfile content';

      expect(
        () => KeyFile.decode(actualInvalidKeyFileJSONString, actualPassword),
        throwsA(isA<InvalidKeyFileException>()),
      );
    });

    test('Should throw InvalidPasswordException for invalid password', () async {
      String actualInvalidPassword = 'invalid PASSWORD';

      expect(
        () => KeyFile.decode(keyFileJSONString, actualInvalidPassword),
        throwsA(isA<InvalidPasswordException>()),
      );
    });
  });
}
