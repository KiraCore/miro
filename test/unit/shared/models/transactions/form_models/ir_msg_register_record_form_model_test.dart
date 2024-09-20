import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_register_record_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

void main() {
  AWalletAddress actualSenderAddress = AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

  group('Tests of IRMsgRegisterRecordFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityValue: 'test_value',
        identityKey: 'test_key',
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRegisterRecordFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (senderWalletAddress)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: null,
        identityKey: 'test_key',
        identityValue: 'test_value',
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRegisterRecordFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (identityKey)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityKey: null,
        identityValue: 'test_value',
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRegisterRecordFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (identityValue)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityKey: 'test_key',
        identityValue: null,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgRegisterRecordFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of IRMsgRegisterRecordFormModel.buildTxMsgModel()', () {
    test('Should [return IRMsgRegisterRecordsModel] if all required form fields are filled', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityKey: 'test_key',
        identityValue: 'test_value',
      );

      // Act
      ATxMsgModel actualIRMsgRegisterRecordsModel = actualIrMsgRegisterRecordFormModel.buildTxMsgModel();

      // Assert
      IRMsgRegisterRecordsModel expectedIrMsgRegisterRecordModel = IRMsgRegisterRecordsModel(
        walletAddress: actualSenderAddress,
        irEntryModels: const <IREntryModel>[
          IREntryModel(
            key: 'test_key',
            info: 'test_value',
          ),
        ],
      );

      expect(actualIRMsgRegisterRecordsModel, expectedIrMsgRegisterRecordModel);
    });

    test('Should [throw Exception] if at least one of required form fields not exists (senderWalletAddress)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: null,
        identityKey: 'test_key',
        identityValue: 'test_value',
      );

      // Assert
      expect(
        () => actualIrMsgRegisterRecordFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exists (identityKey)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityKey: null,
        identityValue: 'test_value',
      );

      // Assert
      expect(
        () => actualIrMsgRegisterRecordFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exists (identityValue)', () {
      // Arrange
      IRMsgRegisterRecordFormModel actualIrMsgRegisterRecordFormModel = IRMsgRegisterRecordFormModel(
        senderWalletAddress: actualSenderAddress,
        identityKey: 'test_key',
        identityValue: null,
      );

      // Assert
      expect(
        () => actualIrMsgRegisterRecordFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
