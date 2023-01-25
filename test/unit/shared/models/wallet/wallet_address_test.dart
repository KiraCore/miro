import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  // @formatter:off
  // Actual values for tests
  final Uint8List actualAddressBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
  final Uint8List actualPublicKeyBytes = Uint8List.fromList(<int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124]);
  const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
  const String actualHexAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';
  const String actualBech32Hrp = 'kira';
  final WalletAddress actualWalletAddress = WalletAddress(addressBytes: actualAddressBytes, bech32Hrp: actualBech32Hrp);

  // Expected values for tests
  final WalletAddress expectedWalletAddress = WalletAddress(addressBytes: actualAddressBytes, bech32Hrp: actualBech32Hrp);
  // @formatter:on

  group('Tests of WalletAddress.fromPublicKey() constructor', () {
    test('Should return correct WalletAddress from given public key bytes', () {
      expect(
        WalletAddress.fromPublicKey(actualPublicKeyBytes, bech32Hrp: actualBech32Hrp),
        expectedWalletAddress,
      );
    });
  });
  group('Tests of WalletAddress.fromBech32() constructor', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      expect(
        WalletAddress.fromBech32(actualBech32Address),
        expectedWalletAddress,
      );
    });
  });
  group('Tests of WalletAddress.fromHex() constructor', () {
    test('Should return correct WalletAddress from given hex address', () {
      expect(
        WalletAddress.fromHex(actualHexAddress, bech32Hrp: actualBech32Hrp),
        expectedWalletAddress,
      );
    });
  });

  group('Tests of toString() method', () {
    test('Should return hex address', () {
      expect(
        actualWalletAddress.toString(),
        '0x437832172d98e523a7fc748b9ed33ac72921964c',
      );
    });
  });

  group('Tests of hex getter', () {
    test('Should return correct calculated hex address with 0x prefix', () {
      expect(
        actualWalletAddress.hex,
        '0x437832172d98e523a7fc748b9ed33ac72921964c',
      );
    });
  });

  group('Tests of hexWithoutPrefix getter', () {
    test('Should return correct hex address without 0x prefix', () {
      expect(
        actualWalletAddress.hexWithoutPrefix,
        '437832172d98e523a7fc748b9ed33ac72921964c',
      );
    });
  });

  group('Tests of bech32Address getter', () {
    test('Should return correct bech32 address', () {
      expect(
        actualWalletAddress.bech32Address,
        'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3',
      );
    });
  });

  group('Tests of buildBech32AddressShort()', () {
    test('Should return short bech32 address with underscore as delimiter', () {
      expect(
        actualWalletAddress.buildBech32AddressShort(delimiter: '_'),
        'kira1gdu_l7u3',
      );
    });

    test('Should return short bech32 address with three dots as delimiter', () {
      expect(
        actualWalletAddress.buildBech32AddressShort(delimiter: '...'),
        'kira1gdu...l7u3',
      );
    });
  });
}