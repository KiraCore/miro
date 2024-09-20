import 'dart:convert';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/identity_info_entry.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_rewards.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_undelegation.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_delegate.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_undelegate.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
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
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart' as miro;
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/network_utils.dart';
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
  final miro.Mnemonic senderMnemonic = miro.Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = await Wallet.derive(mnemonic: senderMnemonic);

  final miro.Mnemonic recipientMnemonic = miro.Mnemonic(value: 'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = await Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  final TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(200),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  final CosmosAuthInfo cosmosAuthInfo = CosmosAuthInfo(
    signerInfos: <CosmosSignerInfo>[
      CosmosSignerInfo(
        publicKey: CosmosSimplePublicKey(base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8')),
        modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
        sequence: 106,
      ),
    ],
    fee: CosmosFee(
      amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.from(200))],
      gasLimit: BigInt.from(20000),
    ),
  );

  final QueryAccountService queryAccountService = globalLocator<QueryAccountService>();

  const TxRemoteInfoModel expectedTxRemoteInfoModel = TxRemoteInfoModel(
    accountNumber: '669',
    chainId: 'testnet-9',
    sequence: '106',
  );

  Future<UnsignedTxModel> buildUnsignedTxModel(TxLocalInfoModel actualTxLocalInfoModel, Wallet wallet) async {
    // Act
    TxRemoteInfoModel actualTxRemoteInfoModel = await queryAccountService.getTxRemoteInfo(wallet.address.address);

    // Assert
    TestUtils.printInfo('Should [return TxRemoteInfoModel] containing address details from INTERX');
    expect(actualTxRemoteInfoModel, expectedTxRemoteInfoModel);

    UnsignedTxModel actualUnsignedTxModel = UnsignedTxModel(
      txLocalInfoModel: actualTxLocalInfoModel,
      txRemoteInfoModel: actualTxRemoteInfoModel,
    );

    return actualUnsignedTxModel;
  }

  group('Tests of transaction preparation for broadcast', () {
    test('Should [return signed transaction] with MsgSend message', () async {
      // Arrange
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgSend message',
            messages: <ProtobufAny>[
              MsgSend(
                fromAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                toAddress: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
                amount: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.from(200))],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('89599907753324820443247350118296506262203633866927351078550723837179327736941'),
              s: BigInt.parse('21866124806975663122088505116775312757127188676174337977018459598244507878684'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with MsgSend message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
                  {'denom': 'ukex', 'amount': '200'}
                ]
              }
            ],
            'memo': 'Test of MsgSend message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['xhfAKWWGRES3j0Aolo9bsWPXxS+fCqIBUMKjiimk7G0wV8m+QeBV+2oH0HikRO2lM2duXVLlvHIHPNSDHfEFHA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgSend message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with IRMsgRegisterRecordsModel message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgRegisterIdentityRecords message',
            messages: <ProtobufAny>[
              MsgRegisterIdentityRecords(
                address: CosmosAccAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
                infos: <IdentityInfoEntry>[
                  const IdentityInfoEntry(key: 'avatar', info: 'https://paganresearch.io/images/kiracore.jpg'),
                ],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('21028702019761272517685992784987639565827921194316081946315444932502726756360'),
              s: BigInt.parse('26233124607299580314002343060441837683740545835168470193313814846944351386003'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with [IRMsgRegisterRecordsModel] message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['Ln3S1LoKALZyd3snOU5M+nL3D57KQ1jAD51eDXJZyAg5/2wfc5JTK/mhLSqfbTrS75pmSRuIAsqnNywlnkR5kw==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgRegisterIdentityRecords message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with IRMsgRequestVerificationModel message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgRequestIdentityRecordsVerify message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgRequestVerificationModel.single(
          recordId: 964,
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgRequestIdentityRecordsVerify message',
            messages: <ProtobufAny>[
              MsgRequestIdentityRecordsVerify(
                recordIds: <int>[964],
                address: CosmosAccAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
                verifier: CosmosAccAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
                tip: CosmosCoin(denom: 'ukex', amount: BigInt.from(200)),
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('87859255067317020921640288784812661833164655904358063561080693251729950488999'),
              s: BigInt.parse('39595110096392771142131991733046522340996157809851989421741243827765031450878'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with IRMsgRequestVerificationModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {
                '@type': '/kira.gov.MsgRequestIdentityRecordsVerify',
                'address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                'verifier': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl',
                'record_ids': [964],
                'tip': {'denom': 'ukex', 'amount': '200'}
              }
            ],
            'memo': 'Test of MsgRequestIdentityRecordsVerify message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['wj6TfOey21l2Bba4/zBgMhYn36CC4pvyNpM5trp/uadXignDER2Hz7AoQFxWvN/pmll/Wu/KyyNl5Ouej6e4/g==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with IRMsgRequestVerificationModel message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with IRMsgCancelVerificationRequestModel message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgCancelVerificationRequestModel(
          verifyRequestId: BigInt.from(3),
          walletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
            messages: <ProtobufAny>[
              MsgCancelIdentityRecordsVerifyRequest(
                executor: CosmosAccAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
                verifyRequestId: BigInt.from(3),
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('9222004436251072072237146921185648206129469369723953401938276983576476066620'),
              s: BigInt.parse('23127075334067262420724200782451981690599091574700651770491012559622830886350'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with IRMsgCancelVerificationRequestModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {'@type': '/kira.gov.MsgCancelIdentityRecordsVerifyRequest', 'executor': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx', 'verify_request_id': '3'}
            ],
            'memo': 'Test of MsgCancelIdentityRecordsVerifyRequest message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['FGN4M8QelKz4mVZfmlRimHZ0lRdYyZEp8jby9UKBIzwzIXX0w+0WLCN5GwYL2BRpMhrXxy1UbEkiizSvBmUNzg==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with IRMsgCancelVerificationRequestModel message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with IRMsgDeleteRecordsModel message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDeleteIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgDeleteRecordsModel.single(
          key: 'avatar',
          walletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgDeleteIdentityRecords message',
            messages: <ProtobufAny>[
              MsgDeleteIdentityRecords(
                address: CosmosAccAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
                keys: <String>['avatar'],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('79026266621337154156741060753401210162338558944713775541782575273128987403966'),
              s: BigInt.parse('5687955546390794418908963039509925541165916791887615280573209458228550913771'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with IRMsgDeleteRecordsModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['rrdIJi1iHdz+w5xskAqC5gnw8u9pmmqL1MbQikC3Jr4Mk0TM+Z+9Kb0XBI1qcOLhWDg9M/yKo5eIf+v4tONO6w==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with IRMsgDeleteRecordsModel message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with IRMsgHandleVerificationRequestModel message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
            messages: <ProtobufAny>[
              MsgHandleIdentityRecordsVerifyRequest(
                verifier: CosmosAccAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
                verifyRequestId: 2,
                yes: true,
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('72933007490609640501865487430495147621153330076791856292083884954279647403436'),
              s: BigInt.parse('18666428172386819201137480101541341517569119196844379112158234304637595425789'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with IRMsgHandleVerificationRequestModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['oT6ej7kXOCV7yhnsK1N/VFl+4VhM/rvx2bkTbezEXawpRNLt4kIghscs1LOYdhVjJ7Om/dPV9Y9ILujvhdIb/Q==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with IRMsgHandleVerificationRequestModel message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with MsgDelegate message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgDelegate message',
            messages: <ProtobufAny>[
              MsgDelegate(
                delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                valoperAddress: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
                amounts: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.from(100))],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('55717454601243069088841521135755802532418319520050179086645302401638805298598'),
              s: BigInt.parse('23913435960359395132492905352374853547098518607227882426156179958185778028864'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with StakingMsgDelegateModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
                  {'denom': 'ukex', 'amount': '100'}
                ]
              }
            ],
            'memo': 'Test of MsgDelegate message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['ey72NRNmSpw+WSvcQQlszNrYe7MV3PNhGF+5QqAwXaY03oZte3st8EvOFmKKt+3GVJvO1yPBPNnrhRjC2ukhQA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgDelegate message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with MsgUndelegate message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
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
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgUndelegate message',
            messages: <ProtobufAny>[
              MsgUndelegate(
                delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                valoperAddress: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
                amounts: <CosmosCoin>[CosmosCoin(denom: 'ukex', amount: BigInt.from(100))],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('72662442560263102468806670475645295622932430335239902677926380471518172892103'),
              s: BigInt.parse('27868048802058524184290366108124533155351530920507136071634942531294406595168'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with StakingMsgUndelegateModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

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
                  {'denom': 'ukex', 'amount': '100'}
                ]
              }
            ],
            'memo': 'Test of MsgUndelegate message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['oKV8LK9bvfakBapLQ1gczT9w6AKIa+Z0orJCqU6xS8c9nMG0PhZAaq1zt9Gczwnr+CpKxqOjAMoQ7DPcPNNSYA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgUndelegate message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with MsgClaimRewards message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgClaimRewards message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimRewardsModel(
          senderWalletAddress: senderWallet.address,
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgClaimRewards message',
            messages: <ProtobufAny>[
              MsgClaimRewards(sender: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('86425581516026662676457875278640935065194214567737986990204734494410721421215'),
              s: BigInt.parse('32517379701721149843822157155487302717605475570919901277046173146033855619460'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with StakingMsgClaimRewardsModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {'@type': '/kira.multistaking.MsgClaimRewards', 'sender': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'}
            ],
            'memo': 'Test of MsgClaimRewards message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['vxMlSVwd9X+NqFhDRhA1UYJ+qCGWuDMsF8fQiHz/Z59H5C9H8EmpDdTuk4waYvNeOkVsLTFJ2n9tCMY1dlNhhA==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgClaimRewards message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });

    test('Should [return signed transaction] with MsgClaimUndelegation message', () async {
      TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgClaimUndelegation message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimUndelegationModel(
          senderWalletAddress: senderWallet.address,
          undelegationId: '1',
        ),
      );

      // Act
      UnsignedTxModel actualUnsignedTxModel = await buildUnsignedTxModel(actualTxLocalInfoModel, senderWallet);
      SignedTxModel actualSignedTxModel = actualUnsignedTxModel.sign(senderWallet);

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: expectedTxRemoteInfoModel,
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgClaimUndelegation message',
            messages: <ProtobufAny>[
              MsgClaimUndelegation(
                sender: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
                undelegationId: BigInt.from(1),
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('28706132851713258574618795789951122613176729275793441545562718387318134318988'),
              s: BigInt.parse('18127497915722753838224045169955328765611750941145002583780850480177807109555'),
            ),
          ],
        ),
      );

      TestUtils.printInfo('Should [return SignedTxModel] with StakingMsgClaimUndelegationModel message');
      expect(actualSignedTxModel, expectedSignedTxModel);

      // *************************************************************************************************************

      // Act
      BroadcastReq actualBroadcastReq = BroadcastReq(tx: actualSignedTxModel.signedCosmosTx);

      // Assert
      Map<String, dynamic> expectedBroadcastReqJson = <String, dynamic>{
        'tx': {
          'body': {
            'messages': [
              {'@type': '/kira.multistaking.MsgClaimUndelegation', 'sender': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx', 'undelegation_id': '1'}
            ],
            'memo': 'Test of MsgClaimUndelegation message',
            'timeout_height': '0',
            'extension_options': [],
            'non_critical_extension_options': []
          },
          'auth_info': {
            'signer_infos': [
              {
                'public_key': {'@type': '/cosmos.crypto.secp256k1.PubKey', 'key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'},
                'mode_info': {
                  'single': {'mode': 'SIGN_MODE_DIRECT'}
                },
                'sequence': '106'
              }
            ],
            'fee': {
              'gas_limit': '20000',
              'amount': [
                {'denom': 'ukex', 'amount': '200'}
              ],
              'payer': null,
              'granter': null
            }
          },
          'signatures': ['P3cYbVw5YzLCCWuq7ck7neCYRhEVrHZBQGHZu9myp4woE8zbp91uA2jF3F2385ZzhREGTwpYcGFqGoWbI8Qtsw==']
        },
        'mode': 'block'
      };

      TestUtils.printInfo('Should [return BroadcastReq] as json with MsgClaimUndelegation message');
      expect(actualBroadcastReq.toJson(), expectedBroadcastReqJson);
    });
  });

  group('Tests for possible exceptions that can be thrown in BroadcastService', () {
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
        signedCosmosTx: CosmosTx.signed(
          authInfo: cosmosAuthInfo,
          body: CosmosTxBody(
            memo: 'Test of MsgRegisterIdentityRecords message',
            messages: <ProtobufAny>[
              MsgRegisterIdentityRecords(
                address: CosmosAccAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
                infos: <IdentityInfoEntry>[
                  const IdentityInfoEntry(key: 'avatar', info: 'https://paganresearch.io/images/kiracore.jpg'),
                ],
              ),
            ],
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.parse('21028702019761272517685992784987639565827921194316081946315444932502726756360'),
              s: BigInt.parse('26233124607299580314002343060441837683740545835168470193313814846944351386003'),
            ),
          ],
        ),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      // Act
      networkModuleBloc.add(NetworkModuleAutoConnectEvent(TestUtils.offlineNetworkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkOfflineModel);

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
