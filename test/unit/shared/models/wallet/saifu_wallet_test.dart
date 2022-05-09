import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  // @formatter:off
  // Actual values for tests
  const String actualPublicAddress = 'kira1gdury9ednrjj8fluwj9ea5e6cu5jr9jvekl7u3';
  final WalletAddress actualWalletAddress = WalletAddress.fromBech32(actualPublicAddress);

  // @formatter:on
  group('Tests of SaifuWallet.fromAddress() constructor', () {
    SaifuWallet saifuWallet = SaifuWallet.fromAddress(address: actualWalletAddress);

    test('Should return valid WalletAddress object', () {
      expect(
        saifuWallet.address,
        actualWalletAddress,
      );
    });
  });
}
