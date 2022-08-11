import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/identity_info_entry.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_register_identity_records.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_cosmos/transactions_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  // Set up the constants to run the tests.
  const String senderMnemonicString =
      'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield';
  final Mnemonic senderMnemonic = Mnemonic(value: senderMnemonicString);
  final Wallet senderWallet = Wallet.derive(mnemonic: senderMnemonic);

  const String recipientMnemonicString =
      'nature light entire memory garden ostrich bottom ensure brand fantasy curtain coast also solve cannon wealth hole quantum fantasy purchase check drift cloth ecology';
  final Mnemonic recipientMnemonic = Mnemonic(value: recipientMnemonicString);
  final Wallet recipientWallet = Wallet.derive(mnemonic: recipientMnemonic);
  const String recipientAddress = 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl';

  const String chainId = 'testnet-9';
  final TxFee fee = TxFee(amount: <Coin>[Coin(denom: 'ukex', value: BigInt.parse('200'))]);

  globalLocator<WalletProvider>().updateWallet(senderWallet);
  final TransactionsService transactionsService = globalLocator<TransactionsService>();

  Future<void> _broadcastTransaction(SignedTransaction signedTransaction) async {
    TestUtils.printInfo('Data request');
    try {
      BroadcastResp actualBroadcastResp = await transactionsService.broadcastTransaction(signedTransaction);

      TestUtils.printInfo('Data return');
      print(actualBroadcastResp);
      print('');
    } on DioError catch (e) {
      TestUtils.printError('transactions_service_test.dart: Cannot fetch BroadcastResp for URI $networkUri: ${e.message}');
    } catch (e) {
      TestUtils.printError('transactions_service_test.dart: Cannot parse BroadcastResp for URI $networkUri: ${e}');
    }
  }

  group('Tests of TransactionsService.signTransaction() method', () {
    test('Should return a signed transaction with MsgSend message', () async {
      final Coin amount = Coin(denom: 'ukex', value: BigInt.parse('200'));

      final TxMsg actualMessage = MsgSend(
        toAddress: WalletAddress.fromBech32(recipientAddress),
        fromAddress: senderWallet.address,
        amount: <Coin>[amount],
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgSend message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgSend transaction: ${json.encode(broadcastReq.toJson())}');
      await _broadcastTransaction(signedTransaction);
    });

    test('Should return a signed transaction with MsgRegisterIdentityRecords message', () async {
      // final IdentityInfoEntry identityInfoEntry = IdentityInfoEntry(
      //   key: 'website',
      //   info: 'https://facebook.com',
      // );

      final IdentityInfoEntry identityInfoEntry = IdentityInfoEntry(
        key: 'avatar',
        info: 'https://paganresearch.io/images/kiracore.jpg',
      );

      final TxMsg actualMessage = MsgRegisterIdentityRecords(
        records: <IdentityInfoEntry>[identityInfoEntry],
        address: senderWallet.address.bech32Address,
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgRegisterIdentityRecords message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgSend transaction: ${json.encode(broadcastReq.toJson())}');
      // await _broadcastTransaction(signedTransaction);
    });

    test('Should return a signed transaction with MsgRequestIdentityRecordsVerify message', () async {
      final BigInt recordId = BigInt.from(954);
      final Coin verifyTip = Coin(denom: 'ukex', value: BigInt.parse('200'));

      final TxMsg actualMessage = MsgRequestIdentityRecordsVerify(
        address: senderWallet.address.bech32Address,
        verifier: recipientAddress,
        tip: verifyTip,
        recordIds: <BigInt>[recordId],
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgRequestIdentityRecordsVerify message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgRequestIdentityRecordsVerify transaction: ${json.encode(broadcastReq.toJson())}');
      // await _broadcastTransaction(signedTransaction);
    });

    test('Should return a signed transaction with MsgCancelIdentityRecordsVerifyRequest message', () async {
      final BigInt verifyRequestId = BigInt.from(3);

      final TxMsg actualMessage = MsgCancelIdentityRecordsVerifyRequest(
        verifyRequestId: verifyRequestId,
        executor: senderWallet.address.bech32Address,
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgCancelIdentityRecordsVerifyRequest message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgCancelIdentityRecordsVerifyRequest transaction: ${json.encode(broadcastReq.toJson())}');
      // await _broadcastTransaction(signedTransaction);
    });

    test('Should return a signed transaction with MsgDeleteIdentityRecords message', () async {
      const String keyValue = 'avatar';

      final TxMsg actualMessage = MsgDeleteIdentityRecords(
        address: senderWallet.address.bech32Address,
        keys: <String>[keyValue],
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgDeleteIdentityRecords message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgDeleteIdentityRecords transaction: ${json.encode(broadcastReq.toJson())}');
      // await _broadcastTransaction(signedTransaction);
    });

    test('Should return a signed transaction with MsgHandleIdentityRecordsVerifyRequest message', () async {
      globalLocator<WalletProvider>().updateWallet(recipientWallet);
      final BigInt verifyRequestId = BigInt.from(2);

      final TxMsg actualMessage = MsgHandleIdentityRecordsVerifyRequest(
        verifier: recipientAddress,
        verifyRequestId: verifyRequestId,
        yes: true,
      );

      final UnsignedTransaction unsignedTransaction = UnsignedTransaction(
        messages: <TxMsg>[actualMessage],
        fee: fee,
        memo: 'Test of MsgHandleIdentityRecordsVerifyRequest message',
      );

      SignedTransaction signedTransaction = await transactionsService.signTransaction(
        unsignedTransaction,
        customChainId: chainId,
      );

      BroadcastReq broadcastReq = BroadcastReq(transaction: signedTransaction);
      TestUtils.printInfo('Signed MsgHandleIdentityRecordsVerifyRequest transaction: ${json.encode(broadcastReq.toJson())}');
      // await _broadcastTransaction(signedTransaction);
    });
  });
}
