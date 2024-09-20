import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/address/ethereum_wallet_address_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of fromString() constructor', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      // Arrange
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';
      Uint8List actualAddressBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      EthereumWalletAddress expectedWalletAddress = EthereumWalletAddress(addressBytes: actualAddressBytes);
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of fromBech32() constructor', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      // Arrange
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromBech32(actualBech32Address);

      // Assert
      EthereumWalletAddress expectedWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of toKiraAddress() function', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      // Arrange
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';

      // Act
      String actualBech32Address = EthereumWalletAddress.fromString(actualEthereumAddress).toKiraAddress();

      // Assert
      const String expectedBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
      expect(actualBech32Address, expectedBech32Address);
    });
  });

  group('Tests of address getter', () {
    test('Should return correct bech32 address', () {
      // Arrange
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      const String expectedEthereumAddress = actualEthereumAddress;
      expect(
        actualWalletAddress.address,
        expectedEthereumAddress,
      );
    });
  });

  group('Tests of buildShortAddress()', () {
    test('Should return short address with underscore as delimiter', () {
      // Arrange
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '_'),
        '0x437832_964c',
      );
    });

    test('Should return short address with three dots as delimiter', () {
      // Arrange
      const String actualEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '...'),
        '0x437832...964c',
      );
    });
  });
}
