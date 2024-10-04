import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<NetworkModuleBloc>(),
])
import 'cosmos_wallet_address_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/wallet/address/cosmos_wallet_address_test.dart --platform chrome --null-assertions
Future<void> main() async {
  MockNetworkModuleBloc mockNetworkModuleBloc = MockNetworkModuleBloc();

  globalLocator.registerLazySingleton<NetworkModuleBloc>(() => mockNetworkModuleBloc);

  when(mockNetworkModuleBloc.tokenDefaultDenomModel).thenReturn(TokenDefaultDenomModel(
    valuesFromNetworkExistBool: true,
    bech32AddressPrefix: 'kira',
    defaultTokenAliasModel: null,
  ));

  group('Tests of WalletAddress.fromPublicKey() constructor', () {
    test('Should return correct WalletAddress from given public key bytes', () {
      // Arrange
      Uint8List actualAddressBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
      Uint8List actualPublicKeyBytes = Uint8List.fromList(
          <int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124]);

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromPublicKey(actualPublicKeyBytes);

      // Assert
      CosmosWalletAddress expectedWalletAddress = CosmosWalletAddress(addressBytes: actualAddressBytes);
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of WalletAddress.fromBech32() constructor', () {
    test('Should return correct WalletAddress from given bech32 address', () {
      // Arrange
      Uint8List actualAddressBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
      String hrp = actualBech32Address.substring(0, 4);

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);

      // Assert
      CosmosWalletAddress expectedWalletAddress = CosmosWalletAddress(addressBytes: actualAddressBytes, bech32Hrp: hrp);
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of WalletAddress.fromEthereum() constructor', () {
    test('Should return correct WalletAddress from given ethereum address', () {
      // Arrange
      Uint8List actualAddressBytes = Uint8List.fromList(<int>[184, 61, 247, 110, 98, 152, 11, 219, 14, 50, 79, 201, 206, 62, 123, 175, 99, 9, 231, 181]);
      const String actualEthereumAddress = '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5';

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromEthereum(actualEthereumAddress);

      // Assert
      CosmosWalletAddress expectedWalletAddress = CosmosWalletAddress(addressBytes: actualAddressBytes, bech32Hrp: 'kira');
      expect(actualWalletAddress, expectedWalletAddress);
    });
  });

  group('Tests of toEthereumAddress() function', () {
    test('Should return correct WalletAddress from given ethereum address', () {
      // Arrange
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      String actualEthereumAddress = CosmosWalletAddress.fromBech32(actualBech32Address).toEthereumAddress();

      // Assert
      const String expectedEthereumAddress = '0x437832172d98e523a7fc748b9ed33ac72921964c';
      expect(actualEthereumAddress, expectedEthereumAddress);
    });
  });

  group('Tests of bech32Address getter', () {
    test('Should return correct bech32 address', () {
      // Arrange
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);

      // Assert
      const String expectedBech32Address = actualBech32Address;
      expect(
        actualWalletAddress.address,
        expectedBech32Address,
      );
    });
  });

  group('Tests of buildShortAddress()', () {
    test('Should return short bech32 address with underscore as delimiter', () {
      // Arrange
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '_'),
        'kira1gdu_l7u3',
      );
    });

    test('Should return short bech32 address with three dots as delimiter', () {
      // Arrange
      const String actualBech32Address = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';

      // Act
      CosmosWalletAddress actualWalletAddress = CosmosWalletAddress.fromBech32(actualBech32Address);

      // Assert
      expect(
        actualWalletAddress.buildShortAddress(delimiter: '...'),
        'kira1gdu...l7u3',
      );
    });
  });
}
