import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  group('Tests of IRRecordModel.isEmpty()', () {
    test('Should return [true] if value is equal null', () {
      // Arrange
      IRRecordModel actualIrRecordModel = const IRRecordModel.empty(key: 'username');

      // Act
      bool actualEmptyBool = actualIrRecordModel.isEmpty();

      // Assert
      expect(actualEmptyBool, true);
    });

    test('Should return [true] if value is empty', () {
      // Arrange
      IRRecordModel actualIrRecordModel = const IRRecordModel(
        id: '3',
        key: 'username',
        value: '',
        verifiersAddresses: <WalletAddress>[],
        pendingVerifiersAddresses: <WalletAddress>[],
        dateTime: null,
      );

      // Act
      bool actualEmptyBool = actualIrRecordModel.isEmpty();

      // Assert
      expect(actualEmptyBool, true);
    });

    test('Should return [false] if value exists and is not empty', () {
      // Arrange
      IRRecordModel actualIrRecordModel = const IRRecordModel(
        id: '3',
        key: 'username',
        value: 'foobar',
        verifiersAddresses: <WalletAddress>[],
        pendingVerifiersAddresses: <WalletAddress>[],
        dateTime: null,
      );

      // Act
      bool actualEmptyBool = actualIrRecordModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });
  });

  group('Tests of IRRecordModel.irRecordStatus', () {
    test('Should return [IRRecordStatus.verified] if IRRecordModel at least one verifier', () {
      // Arrange
      IRRecordModel actualIrRecordModel = IRRecordModel(
        id: '3',
        key: 'username',
        value: 'foobar',
        verifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        pendingVerifiersAddresses: const <WalletAddress>[],
        dateTime: null,
      );

      // Act
      IRRecordStatus actualIrRecordStatus = actualIrRecordModel.irRecordStatus;

      // Assert
      IRRecordStatus expectedIrRecordStatus = IRRecordStatus.verified;
      expect(actualIrRecordStatus, expectedIrRecordStatus);
    });

    test('Should return [IRRecordStatus.pending] if IRRecordModel has only pending verification requests', () {
      // Arrange
      IRRecordModel actualIrRecordModel = IRRecordModel(
        id: '3',
        key: 'username',
        value: 'foobar',
        verifiersAddresses: const <WalletAddress>[],
        pendingVerifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        dateTime: null,
      );

      // Act
      IRRecordStatus actualIrRecordStatus = actualIrRecordModel.irRecordStatus;

      // Assert
      IRRecordStatus expectedIrRecordStatus = IRRecordStatus.pending;
      expect(actualIrRecordStatus, expectedIrRecordStatus);
    });

    test('Should return [IRRecordStatus.notVerified] if IRRecordModel is not verified and does not have pending requests', () {
      // Arrange
      IRRecordModel actualIrRecordModel = const IRRecordModel(
        id: '3',
        key: 'username',
        value: 'foobar',
        verifiersAddresses: <WalletAddress>[],
        pendingVerifiersAddresses: <WalletAddress>[],
        dateTime: null,
      );

      // Act
      IRRecordStatus actualIrRecordStatus = actualIrRecordModel.irRecordStatus;

      // Assert
      IRRecordStatus expectedIrRecordStatus = IRRecordStatus.notVerified;
      expect(actualIrRecordStatus, expectedIrRecordStatus);
    });
  });
}
