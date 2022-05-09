import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/unsafe_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/message_signer.dart';
import 'package:miro/shared/utils/transactions/std_sign_doc.dart';

void main() {
  // @formatter:off
  // Actual Values for tests
  const String actualMnemonicString =
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final UnsafeWallet actualWallet = UnsafeWallet.derive(mnemonic: actualMnemonic);
  final Uint8List actualMessageHashBytes = Uint8List.fromList(<int>[79, 231, 208, 217, 177, 119, 5, 73, 184, 221, 21, 73, 208, 86, 19, 234, 116, 151, 232, 255, 130, 198, 229, 249, 5, 159, 179, 202, 101, 104, 78, 116]);

  // Expected values for tests
  final List<int> expectedSignatureData = <int>[88, 142, 162, 76, 153, 171, 19, 46, 183, 13, 35, 114, 54, 16, 171, 141, 106, 191, 59, 168, 166, 45, 142, 108, 234, 4, 250, 114, 248, 233, 4, 83, 14, 15, 171, 243, 91, 88, 57, 58, 119, 191, 122, 8, 112, 97, 194, 195, 203, 180, 62, 104, 125, 0, 241, 215, 155, 36, 190, 151, 36, 57, 17, 76];
  // @formatter:on

  SaifuWallet saifuWallet =
      SaifuWallet.fromAddress(address: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'));

  group('Tests of MessageSigner.sign() method', () {
    test('Should return correctly generated signature bytes', () {
      expect(
        MessageSigner.sign(actualMessageHashBytes, actualWallet.ecPrivateKey, actualWallet.ecPublicKey),
        expectedSignatureData,
      );
    });
  });

  group('Tests of MessageSigner.validateSignatureString()', () {
    StdSignDoc stdSignDoc = StdSignDoc(
      chainId: 'testnet',
      accountNumber: '669',
      sequence: '5',
      memo: 'Test transaction',
      fee: TxFee(amount: <Coin>[Coin(denom: 'ukex', value: BigInt.from(100))]),
      messages: <TxMsg>[
        MsgSend(
          fromAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          toAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          amount: <Coin>[Coin(denom: 'ukex', value: BigInt.from(100))],
        ),
      ],
    );

    test('Should return true if signature is valid', () {
      expect(
        MessageSigner.validateRawSignature(
          address: saifuWallet.address.addressBytes,
          signature: 'GJbeZ35afeBr7XVmclweWEqUE9+QZ/urq52n8wzvEZxGHwvpcSJfyY4SV4DSo4q7IMJjxkol6DTHq/Zlyj4jZA==',
          message: stdSignDoc.toSignatureJson(),
        ),
        true,
      );
    });

    test('Should return false if signature is invalid', () {
      expect(
        MessageSigner.validateRawSignature(
          address: saifuWallet.address.addressBytes,
          signature: 'AjSIVhVhBdlvx7og3+TKfO9NtvH/kUr8DViXoK+Ak5ZyEkLonKvqu0BIGPxxIU6e5JsaGXA08kw7FyLE+SKiUg==',
          message: stdSignDoc.toSignatureJson(),
        ),
        false,
      );
    });
  });
}