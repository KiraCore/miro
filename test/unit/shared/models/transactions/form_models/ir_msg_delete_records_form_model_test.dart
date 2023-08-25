import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_delete_records_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  WalletAddress actualSenderAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

  group('Tests of IRMsgDeleteRecordsFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIrMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: <IRRecordModel>[
          const IRRecordModel(
            id: '0',
            key: 'key1',
            value: 'value',
            verifiersAddresses: <WalletAddress>[],
            irVerificationRequests: <IRVerificationRequestModel>[],
          ),
        ],
        walletAddress: actualSenderAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgDeleteRecordsFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (irRecordModels)', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIRMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: null,
        walletAddress: actualSenderAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIRMsgDeleteRecordsFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (walletAddress)', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIRMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: <IRRecordModel>[
          const IRRecordModel(
              id: '0', key: 'key1', value: 'value', verifiersAddresses: <WalletAddress>[], irVerificationRequests: <IRVerificationRequestModel>[]),
        ],
        walletAddress: null,
      );

      // Act
      bool actualBuildAvailableBool = actualIRMsgDeleteRecordsFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of IRMsgDeleteRecordsFormModel.buildTxMsgModel()', () {
    test('Should [return IRMsgDeleteRecordsModel] if all required form fields are filled', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIRMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: <IRRecordModel>[
          const IRRecordModel(
              id: '0', key: 'key1', value: 'value', verifiersAddresses: <WalletAddress>[], irVerificationRequests: <IRVerificationRequestModel>[]),
        ],
        walletAddress: actualSenderAddress,
      );

      // Act
      ATxMsgModel actualIrMsgDeleteRecordsModel = actualIRMsgDeleteRecordsFormModel.buildTxMsgModel();

      // Assert
      IRMsgDeleteRecordsModel expectedIrMsgDeleteRecordsModel = IRMsgDeleteRecordsModel(
        keys: const <String>['key1'],
        walletAddress: actualSenderAddress,
      );

      expect(actualIrMsgDeleteRecordsModel, expectedIrMsgDeleteRecordsModel);
    });

    test('Should [throw Exception] if at least one of required form fields not exists (irRecordModels)', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIRMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: null,
        walletAddress: actualSenderAddress,
      );

      // Assert
      expect(
        () => actualIRMsgDeleteRecordsFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exists (walletAddress)', () {
      // Arrange
      IRMsgDeleteRecordsFormModel actualIRMsgDeleteRecordsFormModel = IRMsgDeleteRecordsFormModel(
        irRecordModels: <IRRecordModel>[
          const IRRecordModel(
              id: '0', key: 'key1', value: 'value', verifiersAddresses: <WalletAddress>[], irVerificationRequests: <IRVerificationRequestModel>[]),
        ],
        walletAddress: null,
      );

      // Assert
      expect(
        () => actualIRMsgDeleteRecordsFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
