import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
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
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/broadcast_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  // Set up the constants to run the tests.
  // @formatter:off
  final Mnemonic senderMnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  final Mnemonic recipientMnemonic = Mnemonic(value:  'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology');
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  // @formatter:on

  final TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(200),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  final QueryAccountService queryAccountService = globalLocator<QueryAccountService>();
  final BroadcastService broadcastService = globalLocator<BroadcastService>();

  Future<SignedTxModel> signTx(TxLocalInfoModel actualTxLocalInfoModel, Wallet wallet) async {
    try {
      final TxRemoteInfoModel txRemoteInfoModel = await queryAccountService.getTxRemoteInfo(
        wallet.address.bech32Address,
      );

      final UnsignedTxModel actualUnsignedTxModel = UnsignedTxModel(
        txLocalInfoModel: actualTxLocalInfoModel,
        txRemoteInfoModel: txRemoteInfoModel,
      );

      final SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: wallet,
      );

      return actualSignedTxModel;
    } on DioConnectException catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot fetch [TxRemoteInfoModel] for URI $networkUri: ${e.dioException.message}');
      rethrow;
    } on DioParseException catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot parse [TxRemoteInfoModel] for URI $networkUri: ${e}');
      rethrow;
    } catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Unknown error for URI $networkUri: ${e}');
      rethrow;
    }
  }

  Future<void> broadcastTx(SignedTxModel signedTxModel) async {
    TestUtils.printInfo('Data request');
    try {
      BroadcastRespModel broadcastRespModel = await broadcastService.broadcastTx(signedTxModel);

      TestUtils.printInfo('Data return');
      print(broadcastRespModel);
      print('');
    } on DioConnectException catch (e) {
      TestUtils.printError(
          'broadcast_service_test.dart: Cannot fetch [BroadcastResp] for URI $networkUri: ${e.dioException.message}\n${e.dioException.response}');
    } on DioParseException catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot parse [BroadcastResp] for URI $networkUri: ${e}');
    } on TxBroadcastException catch (e) {
      TestUtils.printError('broadcast_service_test.dart: [TxBroadcastException] for URI $networkUri: ${e.response.data}');
    } catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Unknown error for URI $networkUri: ${e}');
    }
  }

  group('Tests of preparation transaction for broadcast', () {
    test('Should return signed transaction with [MsgSend] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgSend message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgSendModel(
          toWalletAddress: recipientWallet.address,
          fromWalletAddress: senderWallet.address,
          tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [MsgSend] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      await broadcastTx(actualSignedTxModel);
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [IRMsgRegisterRecordsModel] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [IRMsgRequestVerificationModel] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [IRMsgCancelVerificationRequestModel] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [IRMsgDeleteRecordsModel] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });

    test('Should return signed transaction with [IRMsgHandleVerificationRequestModel] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: IRMsgHandleVerificationRequestModel(
          approvalStatusBool: true,
          verifyRequestId: '7',
          walletAddress: recipientWallet.address,
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, recipientWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [IRMsgHandleVerificationRequestModel] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });

    test('Should return signed transaction with [MsgDelegate] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDelegate message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgDelegateModel.single(
          delegatorWalletAddress: senderWallet.address,
          valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
          tokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [MsgDelegate] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with [MsgUndelegate] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgUndelegate message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgUndelegateModel.single(
          delegatorWalletAddress: senderWallet.address,
          valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
          tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [MsgUndelegate] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with [MsgClaimRewards] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgClaimRewards message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimRewardsModel(
          senderWalletAddress: senderWallet.address,
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [MsgClaimRewards] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with [MsgClaimUndelegation] message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgClaimUndelegation message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: StakingMsgClaimUndelegationModel(
          senderWalletAddress: senderWallet.address,
          undelegationId: '1',
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed [MsgClaimUndelegation] transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await broadcastTx(actualSignedTxModel);
    });
  });
}
