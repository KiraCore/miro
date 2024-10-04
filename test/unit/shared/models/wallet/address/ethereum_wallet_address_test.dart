import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<NetworkModuleBloc>(),
])
import 'ethereum_wallet_address_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/address/ethereum_wallet_address_test.dart --platform chrome --null-assertions
Future<void> main() async {
  MockNetworkModuleBloc mockNetworkModuleBloc = MockNetworkModuleBloc();

  globalLocator.registerLazySingleton<NetworkModuleBloc>(() => mockNetworkModuleBloc);

  when(mockNetworkModuleBloc.tokenDefaultDenomModel).thenReturn(TokenDefaultDenomModel(
    valuesFromNetworkExistBool: true,
    bech32AddressPrefix: 'kira',
    defaultTokenAliasModel: null,
  ));

  group('Tests of fromString() constructor', () {
    test('Should return correct WalletAddress from given address', () {
      // Arrange
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';
      Uint8List actualAddressBytes = Uint8List.fromList(<int>[184, 61, 247, 110, 98, 152, 11, 219, 14, 50, 79, 201, 206, 62, 123, 175, 99, 9, 231, 181]);

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      EthereumWalletAddress expectedWalletAddress = EthereumWalletAddress(addressBytes: actualAddressBytes);
      expect(actualWalletAddress, expectedWalletAddress);
    });

    test('Should throw an error due to invalid length', () {
      // Arrange
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309';

      // Assert
      throwsA(() => EthereumWalletAddress.fromString(actualEthereumAddress));
    });
  });

  group('Tests of fromBech32() constructor', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      // Arrange
      const String actualBech32Address = 'kira1hq7lwmnznq9akr3jflyuu0nm4a3snea4za0fra';
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromBech32(actualBech32Address);

      // Assert
      EthereumWalletAddress expectedWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of toKiraAddress() function', () {
    test('Should return correct WalletAddress from given address', () {
      // Arrange
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

      // Act
      String actualBech32Address = EthereumWalletAddress.fromString(actualEthereumAddress).toKiraAddress();

      // Assert
      const String expectedBech32Address = 'kira1hq7lwmnznq9akr3jflyuu0nm4a3snea4za0fra';
      expect(actualBech32Address, expectedBech32Address);
    });
  });

  group('Tests of address getter', () {
    test('Should return correct bech32 address', () {
      // Arrange
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

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
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '_'),
        '0xb83DF7_E7b5',
      );
    });

    test('Should return short address with three dots as delimiter', () {
      // Arrange
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

      // Act
      EthereumWalletAddress actualWalletAddress = EthereumWalletAddress.fromString(actualEthereumAddress);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '...'),
        '0xb83DF7...E7b5',
      );
    });
  });
}
