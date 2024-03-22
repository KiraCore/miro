import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_cancel_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_rewards_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_undelegation_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_undelegate_model.dart';
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
  final Mnemonic senderMnemonic = Mnemonic(
      value:
          'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  final Mnemonic recipientMnemonic = Mnemonic(
      value:
          'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  final TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(200),
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
          tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
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

    test('Should return signed transaction with [IRMsgRegisterRecordsModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgRegisterIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgRegisterRecordsModel.single(
          walletAddress: senderWallet.address,
          irEntryModel: const IREntryModel(
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

      TestUtils.printInfo('Should return [SignedTxModel] with [IRMsgRegisterRecordsModel] message');
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

    test('Should return signed transaction with [IRMsgRequestVerificationModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgRequestIdentityRecordsVerify message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgRequestVerificationModel.single(
          recordId: BigInt.from(964),
          tipTokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(200),
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

      TestUtils.printInfo('Should return [SignedTxModel] with [IRMsgRequestVerificationModel] message');
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

      TestUtils.printInfo('Should return [Tx] as json with [IRMsgRequestVerificationModel] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [IRMsgCancelVerificationRequestModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgCancelVerificationRequestModel(
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

      TestUtils.printInfo('Should return [SignedTxModel] with [IRMsgCancelVerificationRequestModel] message');
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

      TestUtils.printInfo('Should return [Tx] as json with [IRMsgCancelVerificationRequestModel] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [IRMsgDeleteRecordsModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDeleteIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgDeleteRecordsModel.single(
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

      TestUtils.printInfo('Should return [SignedTxModel] with [IRMsgDeleteRecordsModel] message');
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

      TestUtils.printInfo('Should return [Tx] as json with [IRMsgDeleteRecordsModel] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [IRMsgHandleVerificationRequestModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgHandleVerificationRequestModel(
          approvalStatusBool: true,
          verifyRequestId: '2',
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

      TestUtils.printInfo('Should return SignedTxModel with IRMsgHandleVerificationRequestModel message');
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

      TestUtils.printInfo('Should return Tx json with IRMsgHandleVerificationRequestModel message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgDelegate] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDelegate message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgDelegateModel.single(
          valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
          delegatorWalletAddress: senderWallet.address,
          tokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
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
          signature: '+VDMEjwfiab+bolnQzY4G5q1E0a8sIln0k0EA1b6ReJGvWymB/hjvNlu2pdqavKCslwfrAQVQP2isqrxbz2FZA==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [StakingMsgDelegateModel] message');
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
                '@type': '/kira.multistaking.MsgDelegate',
                'delegator_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'validator_address': 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
                'amounts': [
                  {
                    'amount': '100',
                    'denom': 'ukex',
                  }
                ]
              }
            ],
            'memo': 'Test of MsgDelegate message',
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
          'signatures': ['+VDMEjwfiab+bolnQzY4G5q1E0a8sIln0k0EA1b6ReJGvWymB/hjvNlu2pdqavKCslwfrAQVQP2isqrxbz2FZA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgDelegate] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgUndelegate] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgUndelegate message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgUndelegateModel.single(
          valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
          delegatorWalletAddress: senderWallet.address,
          tokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
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
          signature: '//rz08ukc2feJPf/PB8OR+JjZL+NI7kXkmhjb0I+TxkJfjPBtgoFPy6UfEkWtU9QAccAj94jX8TtrQ00j6L6+Q==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [StakingMsgUndelegateModel] message');
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
                '@type': '/kira.multistaking.MsgUndelegate',
                'delegator_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'validator_address': 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
                'amounts': [
                  {
                    'amount': '100',
                    'denom': 'ukex',
                  }
                ]
              }
            ],
            'memo': 'Test of MsgUndelegate message',
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
          'signatures': ['//rz08ukc2feJPf/PB8OR+JjZL+NI7kXkmhjb0I+TxkJfjPBtgoFPy6UfEkWtU9QAccAj94jX8TtrQ00j6L6+Q==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgUndelegate] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgClaimRewards] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgClaimRewards message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimRewardsModel(
          senderWalletAddress: senderWallet.address,
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
          signature: 'n7LHpDL0eFVCospJCjR8EH9C+ib7COZ8p0CVf1z1vD0BAq0j2LDfKVot4lQrV7io0pqdHjxUy7gZq7rLjaSsxA==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [StakingMsgClaimRewardsModel] message');
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
                '@type': '/kira.multistaking.MsgClaimRewards',
                'sender': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
              }
            ],
            'memo': 'Test of MsgClaimRewards message',
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
          'signatures': ['n7LHpDL0eFVCospJCjR8EH9C+ib7COZ8p0CVf1z1vD0BAq0j2LDfKVot4lQrV7io0pqdHjxUy7gZq7rLjaSsxA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgClaimRewards] message');
      expect(
        actualBroadcastReq.toJson(),
        expectedBroadcastReqJson,
      );
    });

    test('Should return signed transaction with [MsgClaimUndelegation] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of ClaimUndelegation message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimUndelegationModel(
          senderWalletAddress: senderWallet.address,
          undelegationId: '1',
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
          signature: '0N4MNaiczcv8Qot5UD0c6aPbG1dttpiI8WCnlynndMk3M0H0m+bnr7RokB35YAscTRchBL1P+i7134q3ksgQ3w==',
        ),
      );

      TestUtils.printInfo('Should return [SignedTxModel] with [StakingMsgClaimUndelegationModel] message');
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
                '@type': '/kira.multistaking.MsgClaimUndelegation',
                'sender': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'undelegation_id': '1',
              }
            ],
            'memo': 'Test of ClaimUndelegation message',
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
          'signatures': ['0N4MNaiczcv8Qot5UD0c6aPbG1dttpiI8WCnlynndMk3M0H0m+bnr7RokB35YAscTRchBL1P+i7134q3ksgQ3w==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should return [Tx] as json with [MsgClaimUndelegation] message');
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
          txMsgModel: IRMsgRegisterRecordsModel.single(
            walletAddress: senderWallet.address,
            irEntryModel: const IREntryModel(
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

    test('Should throw [DioConnectException] if [server OFFLINE] (lost connection)', () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      NetworkUnknownModel networkOfflineUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://offline.kira.network'),
        name: 'offline-mainnet',
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
        tokenDefaultDenomModel: TokenDefaultDenomModel(
          valuesFromNetworkExistBool: true,
          bech32AddressPrefix: 'kira',
          defaultTokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      );

      NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        name: 'offline-mainnet',
        uri: Uri.parse('https://offline.kira.network'),
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
        tokenDefaultDenomModel: TokenDefaultDenomModel(
          valuesFromNetworkExistBool: true,
          bech32AddressPrefix: 'kira',
          defaultTokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      );

      // Act
      networkModuleBloc.add(NetworkModuleAutoConnectEvent(networkOfflineUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(networkOfflineModel);

      TestUtils.printInfo('Should return [NetworkModuleState.connected with NetworkOfflineModel]');
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
