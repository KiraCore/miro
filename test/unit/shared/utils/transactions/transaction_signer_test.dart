import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/transaction_signer.dart';
import 'package:miro/test/mock_locator.dart';

// To run tests use:
// fvm flutter test "test/unit/shared/utils/transactions/transaction_signer_test.dart" --platform chrome
Future<void> main() async {
  // Set up test
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  await initMockLocator();

  // Actual values for tests
  const String actualMnemonicString =
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);

  const String actualMemo = 'Test transaction';
  const String actualSequence = '5';
  const String actualAccountNumber = '669';
  const String actualChainId = 'testnet';

  final WalletAddress actualSenderAddress = actualWallet.address;
  final WalletAddress actualRecipientAddress = WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl');

  final Coin actualAmount = Coin(denom: 'ukex', value: BigInt.from(100));
  final Coin actualFee = Coin(denom: 'ukex', value: BigInt.from(100));

  final UnsignedTransaction actualUnsignedTransaction = UnsignedTransaction(
    messages: <TxMsg>[
      MsgSend(
        fromAddress: actualSenderAddress,
        toAddress: actualRecipientAddress,
        amount: <Coin>[actualAmount],
      ),
    ],
    memo: actualMemo,
    fee: TxFee(
      amount: <Coin>[
        actualFee,
      ],
    ),
  );

  final SignedTransaction actualSignedTransaction = TransactionSigner.sign(
    unsignedTransaction: actualUnsignedTransaction,
    ecPublicKey: actualWallet.ecPublicKey,
    ecPrivateKey: actualWallet.ecPrivateKey,
    sequence: actualSequence,
    accountNumber: actualAccountNumber,
    chainId: actualChainId,
  );

  // Expected values for tests
  const String expectedSignature = 'GJbeZ35afeBr7XVmclweWEqUE9+QZ/urq52n8wzvEZxGHwvpcSJfyY4SV4DSo4q7IMJjxkol6DTHq/Zlyj4jZA==';

  final Map<String, dynamic> expectedTransactionJson = <String, dynamic>{
    'body': <String, dynamic>{
      'messages': <Map<String, dynamic>>[
        <String, dynamic>{
          '@type': '/cosmos.bank.v1beta1.MsgSend',
          'from_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
          'to_address': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
          'amount': <Map<String, dynamic>>[
            <String, dynamic>{'amount': actualAmount.value.toString(), 'denom': actualAmount.denom}
          ]
        }
      ],
      'memo': actualMemo,
      'timeout_height': '0',
      'extension_options': <dynamic>[],
      'non_critical_extension_options': <dynamic>[]
    },
    'auth_info': <String, dynamic>{
      'signer_infos': <Map<String, dynamic>>[
        <String, dynamic>{
          'public_key': <String, dynamic>{'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
          'mode_info': <String, dynamic>{
            'single': <String, dynamic>{'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
          },
          'sequence': '5'
        }
      ],
      'fee': <String, dynamic>{
        'amount': <Map<String, dynamic>>[
          <String, dynamic>{'amount': actualFee.value.toString(), 'denom': actualFee.denom}
        ],
        'gas_limit': '999999'
      }
    },
    'signatures': <String>[
      expectedSignature,
    ],
  };

  group('Tests of TransactionSigner.sign() method', () {
    test('Should return correctly generated signature', () {
      expect(
        actualSignedTransaction.signatures.first,
        expectedSignature,
      );
    });

    test('Should build valid json from Transaction object', () {
      expect(
        actualSignedTransaction.toJson(),
        expectedTransactionJson,
      );
    });
  });
}
