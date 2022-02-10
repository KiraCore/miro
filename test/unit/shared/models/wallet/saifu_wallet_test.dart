import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  // @formatter:off
  // Actual values for tests
  const String actualPublicAddress = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
  final WalletAddress actualWalletAddress = WalletAddress.fromBech32(actualPublicAddress);

  // Expected values for tests
  final List<int> expectedPublicKeyBytes = <int>[67,120,50,23,45,152,229,35,167,252,116,139,158,211,58,199,41,33,150,76];
  const String expectedBech32PublicKey = 'kirapub1addwnpepgdury9ednrjj8fluwj9ea5e6cu5jr9jv3rxw9t';

  // @formatter:on
  group('Tests of SaifuWallet.fromAddress() constructor', () {
    SaifuWallet saifuWallet = SaifuWallet.fromAddress(address: actualWalletAddress);

    test('Should return valid public key as bytes', () {
      expect(
        saifuWallet.publicKey,
        expectedPublicKeyBytes,
      );
    });

    test('Should return valid WalletAddress object', () {
      expect(
        saifuWallet.address,
        actualWalletAddress,
      );
    });

    test('Should return valid public key as bech32', () {
      expect(
        saifuWallet.bech32PublicKey,
        expectedBech32PublicKey,
      );
    });
  });
}
