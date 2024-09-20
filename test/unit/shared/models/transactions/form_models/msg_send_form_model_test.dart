import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

void main() {
  AWalletAddress actualSenderAddress = AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  AWalletAddress actualRecipientAddress = AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl');
  TokenAmountModel actualTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  group('Tests of MsgSendFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Act
      bool actualBuildAvailableBool = actualMsgSendFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if all required form fields are filled, but amount is equal "0"', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(0),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      );

      // Act
      bool actualBuildAvailableBool = actualMsgSendFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (senderWalletAddress)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: null,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Act
      bool actualBuildAvailableBool = actualMsgSendFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (recipientWalletAddress)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: null,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Act
      bool actualBuildAvailableBool = actualMsgSendFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (tokenAmountModel)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: null,
      );

      // Act
      bool actualBuildAvailableBool = actualMsgSendFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of MsgSendFormModel.buildTxMsgModel()', () {
    test('Should [return MsgSendModel] if all required form fields are filled', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Act
      ATxMsgModel actualMsgSendModel = actualMsgSendFormModel.buildTxMsgModel();

      // Assert
      MsgSendModel expectedMsgSendModel = MsgSendModel(
        fromWalletAddress: actualSenderAddress,
        toWalletAddress: actualRecipientAddress,
        tokenAmountModel: actualTokenAmountModel,
      );

      expect(actualMsgSendModel, expectedMsgSendModel);
    });

    test('Should [throw Exception] if all required form fields are filled, but amount is equal "0"', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(0),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      );

      // Assert
      expect(
        () => actualMsgSendFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (senderWalletAddress)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: null,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Assert
      expect(
        () => actualMsgSendFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (recipientWalletAddress)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: null,
        tokenAmountModel: actualTokenAmountModel,
      );

      // Assert
      expect(
        () => actualMsgSendFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (tokenAmountModel)', () {
      // Arrange
      MsgSendFormModel actualMsgSendFormModel = MsgSendFormModel(
        senderWalletAddress: actualSenderAddress,
        recipientWalletAddress: actualRecipientAddress,
        tokenAmountModel: null,
      );

      // Assert
      expect(
        () => actualMsgSendFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
