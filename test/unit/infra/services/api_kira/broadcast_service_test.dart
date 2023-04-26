import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_cancel_identity_records_verify_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_delete_identity_records_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_handle_identity_records_verify_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_request_identity_records_verify_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/identity_info_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/msg_register_identity_records_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/broadcast_service_test.dart --platform chrome --null-assertions
// ignore_for_file: always_specify_types
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  // Set up the constants to run the tests.
  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  final Mnemonic recipientMnemonic = Mnemonic(value:  'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  final TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(200),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  final QueryAccountService queryAccountService = globalLocator<QueryAccountService>();

  const TxRemoteInfoModel expectedTxRemoteInfoModel = TxRemoteInfoModel(
    accountNumber: '669',
    chainId: 'testnet-9',
    sequence: '106',
  );

  Future<UnsignedTxModel> buildUnsignedTxModel(TxLocalInfoModel actualTxLocalInfoModel, Wallet wallet) async {
    // Act
    final TxRemoteInfoModel actualTxRemoteInfoModel = await queryAccountService.getTxRemoteInfo(
      wallet.address.bech32Address,
    );

    // Assert
    TestUtils.printInfo('Should return [TxRemoteInfoModel], basing on interx response');
    expect(
      actualTxRemoteInfoModel,
      expectedTxRemoteInfoModel,
    );

    final UnsignedTxModel actualUnsignedTxModel = UnsignedTxModel(
      txLocalInfoModel: actualTxLocalInfoModel,
      txRemoteInfoModel: actualTxRemoteInfoModel,
    );

    return actualUnsignedTxModel;
  }

  group('Tests of transaction preparation for broadcast', () {
    test('Should return signed transaction with [MsgSend] message', () async {
      // Arrange
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgSend message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgSendModel(
          toWalletAddress: recipientWallet.address,
          fromWalletAddress: senderWallet.address,
          tokenAmountModel: TokenAmountModel(lowestDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: 'BiGCQuQyTtJqgNjx9F+FXDxmj/hThzrg1tJuSlxLV9oCoScjKgCf7hAryazvpJLrh5L1IDr74HECJML8TSBbSg==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [MsgSend] message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/cosmos.bank.v1beta1.MsgSend',
                'from_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'to_address': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
                'amount': [
                  {'amount': '200', 'denom': 'ukex'}
                ]
              }
            ],
            'memo': 'Test of MsgSend message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['BiGCQuQyTtJqgNjx9F+FXDxmj/hThzrg1tJuSlxLV9oCoScjKgCf7hAryazvpJLrh5L1IDr74HECJML8TSBbSg==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgSend] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgRegisterIdentityRecords] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgRegisterIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgRegisterIdentityRecordsModel.single(
          walletAddress: senderWallet.address,
          identityInfoEntryModel: const IdentityInfoEntryModel(
            key: 'avatar',
            info: 'https://paganresearch.io/images/kiracore.jpg',
          ),
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: '+Odo/kQ6xBNJCakUnZkmFq0H1tW3pgRYgnLB9ul3iMkj/XElK6pU+bHluRmiONMovMNEDKjvphZeahabtkWTiw==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [MsgRegisterIdentityRecords] message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/kira.gov.MsgRegisterIdentityRecords',
                'address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'infos': [
                  {'key': 'avatar', 'info': 'https://paganresearch.io/images/kiracore.jpg'}
                ]
              }
            ],
            'memo': 'Test of MsgRegisterIdentityRecords message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['+Odo/kQ6xBNJCakUnZkmFq0H1tW3pgRYgnLB9ul3iMkj/XElK6pU+bHluRmiONMovMNEDKjvphZeahabtkWTiw==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgRegisterIdentityRecords] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgRequestIdentityRecordsVerify] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgRequestIdentityRecordsVerify message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgRequestIdentityRecordsVerifyModel.single(
          recordId: BigInt.from(964),
          tipTokenAmountModel: TokenAmountModel(
            lowestDenominationAmount: Decimal.fromInt(200),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
          verifierWalletAddress: recipientWallet.address,
          walletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: 'SP135sI53JAnIENl3AZJoxvDXhBwCyJXuYD0HfJBVooQEHB+tyl1kkNhbyyisobSXaHpaa/Je3J2LoRzOF1zCw==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [MsgRequestIdentityRecordsVerify] message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/kira.gov.MsgRequestIdentityRecordsVerify',
                'address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'record_ids': ['964'],
                'tip': {'amount': '200', 'denom': 'ukex'},
                'verifier': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'
              }
            ],
            'memo': 'Test of MsgRequestIdentityRecordsVerify message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['SP135sI53JAnIENl3AZJoxvDXhBwCyJXuYD0HfJBVooQEHB+tyl1kkNhbyyisobSXaHpaa/Je3J2LoRzOF1zCw==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgRequestIdentityRecordsVerify] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgCancelIdentityRecordsVerifyRequest] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgCancelIdentityRecordsVerifyRequestModel(
          verifyRequestId: BigInt.from(3),
          walletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: 'egYEN3Npnb6lqcQ5mStDQ0KXezrUTlj8iBIRho3yzOZXDPMIT6xEs8jYs/zeV96UVkD6cc3u/2FpeqsoT2qs2Q==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [MsgCancelIdentityRecordsVerifyRequest] message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {'@type': '/kira.gov.MsgCancelIdentityRecordsVerifyRequest', 'executor': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx', 'verify_request_id': '3'}
            ],
            'memo': 'Test of MsgCancelIdentityRecordsVerifyRequest message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['egYEN3Npnb6lqcQ5mStDQ0KXezrUTlj8iBIRho3yzOZXDPMIT6xEs8jYs/zeV96UVkD6cc3u/2FpeqsoT2qs2Q==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgRequestIdentityRecordsVerify] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgDeleteIdentityRecords] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDeleteIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgDeleteIdentityRecordsModel.single(
          key: 'avatar',
          walletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: '7RlYHsYAmMqbeqaI4C3lET3XIdqQgy3StwA1AjccFdQwtp/he34Zhhdu22JbqUTmBGc9zPWPBdTo1/X57UZQAg==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [MsgDeleteIdentityRecordsModel] message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/kira.gov.MsgDeleteIdentityRecords',
                'address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'keys': ['avatar']
              }
            ],
            'memo': 'Test of MsgDeleteIdentityRecords message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['7RlYHsYAmMqbeqaI4C3lET3XIdqQgy3StwA1AjccFdQwtp/he34Zhhdu22JbqUTmBGc9zPWPBdTo1/X57UZQAg==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgDeleteIdentityRecordsModel] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgHandleIdentityRecordsVerifyRequest] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgHandleIdentityRecordsVerifyRequestModel(
          approvedBool: true,
          verifyRequestId: BigInt.from(2),
          walletAddress: recipientWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: senderWallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: 'GqNVZKBGhhE0udHNFJ+g3KhveVkT0BkWPeMQR0Jx6wlO3gYzAzN9nV/KcZQCgKSpYfxLXxEeayVucHnHM9gVGw==',
        ),
      );

      TestUtils.printInfo('Should return SignedTxModel with MsgHandleIdentityRecordsVerifyRequest message');
      expect(
        actualSignedTxModel,
        expectedSignedTxModel,
      );

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/kira.gov.MsgHandleIdentityRecordsVerifyRequest',
                'verifier': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
                'verify_request_id': '2',
                'yes': true
              }
            ],
            'memo': 'Test of MsgHandleIdentityRecordsVerifyRequest message',
            'timeout_height': '0',
            'extension_options': <dynamic>[],
            'non_critical_extension_options': <dynamic>[]
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_LEGACY_AMINO_JSON'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'amount': [
                {'amount': '200', 'denom': 'ukex'}
              ],
              'gas_limit': '999999'
            }
          },
          'signatures': ['GqNVZKBGhhE0udHNFJ+g3KhveVkT0BkWPeMQR0Jx6wlO3gYzAzN9nV/KcZQCgKSpYfxLXxEeayVucHnHM9gVGw==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return Tx json with MsgHandleIdentityRecordsVerifyRequest message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });
  });

  group('Tests for possible exceptions that can be thrown in [BroadcastService]', () {
    // Arrange
    late BroadcastService actualBroadcastService;
    late SignedTxModel actualSignedTxModel;

    setUpAll(() {
      actualBroadcastService = BroadcastService();
      actualSignedTxModel = SignedTxModel(
        txLocalInfoModel: TxLocalInfoModel(
          memo: 'Test of MsgRegisterIdentityRecords message',
          feeTokenAmountModel: feeTokenAmountModel,
          txMsgModel: MsgRegisterIdentityRecordsModel.single(
            walletAddress: senderWallet.address,
            identityInfoEntryModel: const IdentityInfoEntryModel(
              key: 'avatar',
              info: 'https://paganresearch.io/images/kiracore.jpg',
            ),
          ),
        ),
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        signatureModel: const SignatureModel(
          signature: '+Odo/kQ6xBNJCakUnZkmFq0H1tW3pgRYgnLB9ul3iMkj/XElK6pU+bHluRmiONMovMNEDKjvphZeahabtkWTiw==',
        ),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      // Act
      networkModuleBloc.add(NetworkModuleDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return [NetworkModuleState.disconnected()]');
      expect(networkModuleBloc.state, expectedNetworkModuleState);

      // ****************************************************************************************

      // Assert
      TestUtils.printInfo('Should throw [DioConnectException] if network is disconnected');
      expect(
        () async => actualBroadcastService.broadcastTx(actualSignedTxModel),
        throwsA(isA<DioConnectException>()),
      );
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      // Act
      networkModuleBloc.add(NetworkModuleConnectEvent(TestUtils.networkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkUnhealthyModel);

      TestUtils.printInfo('Should return [NetworkModuleState.connected()] with unhealthy network');
      expect(networkModuleBloc.state, expectedNetworkModuleState);

      // ****************************************************************************************

      // Assert
      // To perform this test created mocked API response [/lib/test/mocks/api_kira/mock_api_kira_txs.dart][dioParseExceptionResponse]
      // Assumed that server with the uri "https://unhealthy.kira.network" will return response that is not supported by the application.
      // Because of that, the application will throw [DioParseException] exception.
      // Repository mocks for this test are handled by class located in [/lib/test/mock_api_kira_repository.dart]

      TestUtils.printInfo('Should throw [DioParseException]');
      expect(
        () async => actualBroadcastService.broadcastTx(actualSignedTxModel),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [TxBroadcastException] if [server HEALTHY], [response data VALID] and [broadcast FAILED]', () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      // Act
      networkModuleBloc.add(NetworkModuleConnectEvent(TestUtils.customNetworkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.customNetworkUnhealthyModel);

      TestUtils.printInfo('Should return [NetworkModuleState.connected()] with custom unhealthy network');
      expect(networkModuleBloc.state, expectedNetworkModuleState);

      // ****************************************************************************************

      // Assert
      // To perform this test created mocked API response [/lib/test/mocks/api_kira/mock_api_kira_txs.dart][txBroadcastExceptionResponse]
      // Assumed that server with the uri "https://custom-unhealthy.kira.network" will return response with error message created by interx or sekai.
      // Because of that, the application will throw [TxBroadcastException] exception.
      // Repository mocks for this test are handled by class located in [/lib/test/mock_api_kira_repository.dart]

      TestUtils.printInfo('Should throw [TxBroadcastException]');
      expect(
        () async => actualBroadcastService.broadcastTx(actualSignedTxModel),
        throwsA(isA<TxBroadcastException>()),
      );
    });
  });
}
