import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/transactions/message_signer.dart';

void main() {
  // @formatter:off
  // Actual Values for tests
  const String actualMnemonicString =
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);
  final Uint8List actualMessageHashBytes = Uint8List.fromList(<int>[79, 231, 208, 217, 177, 119, 5, 73, 184, 221, 21, 73, 208, 86, 19, 234, 116, 151, 232, 255, 130, 198, 229, 249, 5, 159, 179, 202, 101, 104, 78, 116]);

  // Expected values for tests
  final List<int> expectedSignatureData = <int>[88, 142, 162, 76, 153, 171, 19, 46, 183, 13, 35, 114, 54, 16, 171, 141, 106, 191, 59, 168, 166, 45, 142, 108, 234, 4, 250, 114, 248, 233, 4, 83, 14, 15, 171, 243, 91, 88, 57, 58, 119, 191, 122, 8, 112, 97, 194, 195, 203, 180, 62, 104, 125, 0, 241, 215, 155, 36, 190, 151, 36, 57, 17, 76];
  // @formatter:on

  group('Tests of MessageSigner.sign() method', () {
    test('Should return correctly generated signature bytes', () {
      expect(
        MessageSigner.sign(actualMessageHashBytes, actualWallet.ecPrivateKey, actualWallet.ecPublicKey),
        expectedSignatureData,
      );
    });
  });
}