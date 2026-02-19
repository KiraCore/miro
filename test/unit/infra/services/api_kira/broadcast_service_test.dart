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
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart' as miro;
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
  final miro.Mnemonic senderMnemonic = miro.Mnemonic(
      value:
          'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = await Wallet.derive(mnemonic: senderMnemonic);

  final miro.Mnemonic recipientMnemonic = miro.Mnemonic(
      value:
          'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
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
    chainId: 'chaosnet-3',
    sequence: '106',
  );

  Future<UnsignedTxModel> buildUnsignedTxModel(TxLocalInfoModel actualTxLocalInfoModel, Wallet wallet) async {
    // Act
    TxRemoteInfoModel actualTxRemoteInfoModel = await queryAccountService.getTxRemoteInfo(wallet.address.bech32Address);

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
          tokenAmountModel: TokenAmountModel(
              defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
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
              r: BigInt.parse('87210495893218317095255233268404102142751695108290619698850115003174215234681'),
              s: BigInt.parse('45411297726047489424127761369438972633246783922086216053171352377478916185669'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('81462215629719951979634509938955619315107482090980120075887583641124397032729'),
              s: BigInt.parse('12602475644664476140615683987215242708651334418181655983183239645001338385008'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('28622637028936030332117260227994882072988874700543359100240119344669394624032'),
              s: BigInt.parse('19207168361135260140021182333673872674666487811671149620084823021487723864310'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('31232248174095207544342671878213935777020994089313743004864283199747032263997'),
              s: BigInt.parse('51404598275262285256961862479059959812080851722907748991544697286113012489958'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('2827251627967082034480454865517039787635816062510971591133421535027256536753'),
              s: BigInt.parse('40580133900051328725926516202096020513226356576835140069895802405218567055279'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('4679026604295451811574538368257951426203884790055712357698997033359161597053'),
              s: BigInt.parse('2862432958834089068891556309498036265460345512697083089866257605118932235792'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('36963537132482751407040770060826202806349712073634475375590692173675695186314'),
              s: BigInt.parse('35988462218872473104654069127988726802924495389527066577425455965744470548083'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('2362943053475727851284523008578566586497485545324303876980711984001631218711'),
              s: BigInt.parse('48671315251095642604608705321631282645377068104920044361416096941264163970061'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('38798294442548980397203758645648800064841785374950106927163026336447713518063'),
              s: BigInt.parse('40511601450211613571736454485376726505782836193351265601527838863761521981703'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('53931784389281119594632275428448450459414293822686472631969037035733632417282'),
              s: BigInt.parse('3869579630251616776362004995596474187923215105870002098602300766616730535382'),
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
        'tx': base64Encode(expectedSignedTxModel.signedCosmosTx.toProtoBytes()),
        'mode': 'sync'
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
              r: BigInt.parse('81462215629719951979634509938955619315107482090980120075887583641124397032729'),
              s: BigInt.parse('12602475644664476140615683987215242708651334418181655983183239645001338385008'),
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

    test('Should throw [TxBroadcastException] if [server HEALTHY], [response data VALID] and [broadcast FAILED]',
        () async {
      // Arrange
      NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

      // Act
      networkModuleBloc.add(NetworkModuleConnectEvent(TestUtils.customNetworkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Assert
      NetworkModuleState expectedNetworkModuleState =
          NetworkModuleState.connected(TestUtils.customNetworkUnhealthyModel);

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
