import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

void main() {
  AWalletAddress actualRequesterWalletAddress = AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  AWalletAddress actualVerifierWalletAddress = AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl');
  TokenAmountModel actualTipTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TokenAliasModel.local('ukex'),
  );

  IRRecordModel actualIrRecordModel = IRRecordModel(
    id: '3',
    key: 'username',
    value: 'somnitear',
    verifiersAddresses: const <AWalletAddress>[],
    pendingVerifiersAddresses: <AWalletAddress>[
      AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    ],
  );

  group('Tests of IRMsgRequestVerificationFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRequestVerificationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if all required form fields are filled, but tip is equal "0"', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(0),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRequestVerificationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (tipTokenAmountModel)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: null,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRequestVerificationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists  (requesterWalletAddress)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: null,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRequestVerificationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (verifierWalletAddress)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: null,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRequestVerificationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of IRMsgRequestVerificationFormModel.buildTxMsgModel()', () {
    test('Should [return IRMsgRequestVerificationModel] if all required form fields are filled', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Act
      ATxMsgModel actualIrMsgRequestVerificationModel = actualIrMsgRequestVerificationFormModel.buildTxMsgModel();

      // Assert
      IRMsgRequestVerificationModel expectedIrMsgRequestVerificationModel = IRMsgRequestVerificationModel(
        recordIds: const <int>[3],
        tipTokenAmountModel: actualTipTokenAmountModel,
        walletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      expect(actualIrMsgRequestVerificationModel, expectedIrMsgRequestVerificationModel);
    });

    test('Should [throw Exception] if all required form fields are filled, but tip is equal "0"', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(0),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );

      // Assert
      expect(
        () => actualIrMsgRequestVerificationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exist (tipTokenAmountModel)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: null,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: actualVerifierWalletAddress,
      );
      // Assert
      expect(
        () => actualIrMsgRequestVerificationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exist (requesterWalletAddress)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: null,
        verifierWalletAddress: actualVerifierWalletAddress,
      );
      // Assert
      expect(
        () => actualIrMsgRequestVerificationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exist (verifierWalletAddress)', () {
      // Arrange
      IRMsgRequestVerificationFormModel actualIrMsgRequestVerificationFormModel = IRMsgRequestVerificationFormModel(
        irRecordModel: actualIrRecordModel,
        tipTokenAmountModel: actualTipTokenAmountModel,
        requesterWalletAddress: actualRequesterWalletAddress,
        verifierWalletAddress: null,
      );
      // Assert
      expect(
        () => actualIrMsgRequestVerificationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
