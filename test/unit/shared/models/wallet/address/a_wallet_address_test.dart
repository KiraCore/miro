import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/address/a_wallet_address_test.dart --platform chrome --null-assertions
Future<void> main() async {
  group('Tests of AWalletAddress.fromAddress() constructor', () {
    test('Should [return CosmosWalletAddress] from given address', () {
      // Arrange
      String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      AWalletAddress actualWalletAddress = AWalletAddress.fromAddress(actualBech32Address);

      // Assert
      CosmosWalletAddress expectedBech32WalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);
      expect(actualWalletAddress, expectedBech32WalletAddress);
    });

    test('Should [return EthereumWalletAddress] from given address', () {
      // Arrange
      String actualEthereumAddress = '0x3f0a5e5e5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b';

      // Act
      AWalletAddress actualWalletAddress = AWalletAddress.fromAddress(actualEthereumAddress);

      // Assert
      EthereumWalletAddress expectedEthereumWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);
      expect(actualWalletAddress, expectedEthereumWalletAddress);
    });

    test('Should [throw Exception] from invalid address', () {
      // Arrange
      String actualRandomAddress = 'ghgh1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Assert
      expect(
        () => AWalletAddress.fromAddress(actualRandomAddress),
        throwsException,
      );
    });
  });

  group('Tests of AWalletAddress.fromValidatorAddress() constructor', () {
    test('Should [return CosmosWalletAddress] from given address', () {
      // Arrange
      String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      AWalletAddress actualWalletAddress = AWalletAddress.fromValidatorAddress(actualBech32Address);

      // Asset
      CosmosWalletAddress expectedBech32WalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);
      expect(actualWalletAddress, expectedBech32WalletAddress);
    });

    test('Should [return EthereumWalletAddress] from given address', () {
      // Arrange
      String actualEthereumAddress = '0x3f0a5e5e5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b';

      // Act
      AWalletAddress actualWalletAddress = AWalletAddress.fromValidatorAddress(actualEthereumAddress);

      // Assert
      EthereumWalletAddress expectedEthereumWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);
      expect(actualWalletAddress, expectedEthereumWalletAddress);
    });

    test('Should [throw Exception] from invalid address', () {
      // Arrange
      String actualRandomAddress = 'ghgh1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Assert
      expect(
        () => AWalletAddress.fromValidatorAddress(actualRandomAddress),
        throwsException,
      );
    });
  });
}
