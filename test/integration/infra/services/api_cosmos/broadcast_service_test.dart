import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/services/api_cosmos/broadcast_service.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_cancel_identity_records_verify_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_delete_identity_records_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_handle_identity_records_verify_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/msg_request_identity_records_verify_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/identity_info_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/msg_register_identity_records_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/shared/utils/transactions/tx_signer.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_cosmos/broadcast_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://85.190.254.164:11000/');
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

      final SignedTxModel actualSignedTxModel = TxSigner.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: wallet,
      );

      return actualSignedTxModel;
    } on DioError catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot fetch TxRemoteInfoModel for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot parse TxRemoteInfoModel for URI $networkUri: ${e}');
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
    } on DioError catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot fetch BroadcastResp for URI $networkUri: ${e.message}\n${e.response}');
    } catch (e) {
      TestUtils.printError('broadcast_service_test.dart: Cannot parse BroadcastResp for URI $networkUri: ${e}');
    }
  }

  group('Tests of preparation transaction for broadcast', () {
    test('Should return a signed transaction with MsgSend message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgSend message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgSendModel(
          toWalletAddress: recipientWallet.address,
          fromWalletAddress: senderWallet.address,
          tokenAmountModel: TokenAmountModel(lowestDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgSend transaction: ${json.encode(actualBroadcastReq.toJson())}');

      await broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with MsgRegisterIdentityRecords message', () async {
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgRegisterIdentityRecords transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await _broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with MsgRequestIdentityRecordsVerify message', () async {
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

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgRequestIdentityRecordsVerify transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await _broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with MsgCancelIdentityRecordsVerifyRequest message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgCancelIdentityRecordsVerifyRequestModel(
          verifyRequestId: BigInt.from(3),
          walletAddress: senderWallet.address,
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgCancelIdentityRecordsVerifyRequest transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await _broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with MsgDeleteIdentityRecords message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgDeleteIdentityRecords message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgDeleteIdentityRecordsModel.single(
          key: 'avatar',
          walletAddress: senderWallet.address,
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, senderWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgDeleteIdentityRecords transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await _broadcastTx(actualSignedTxModel);
    });

    test('Should return a signed transaction with MsgHandleIdentityRecordsVerifyRequest message', () async {
      final TxLocalInfoModel actualTxLocalInfoModel = TxLocalInfoModel(
        memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
        feeTokenAmountModel: feeTokenAmountModel,
        txMsgModel: MsgHandleIdentityRecordsVerifyRequestModel(
          approved: true,
          verifyRequestId: BigInt.from(7),
          walletAddress: recipientWallet.address,
        ),
      );

      SignedTxModel actualSignedTxModel = await signTx(actualTxLocalInfoModel, recipientWallet);

      BroadcastReq actualBroadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(actualSignedTxModel));
      TestUtils.printInfo('Signed MsgHandleIdentityRecordsVerifyRequest transaction: ${json.encode(actualBroadcastReq.toJson())}');

      // await _broadcastTx(actualSignedTxModel);
    });
  });
}
