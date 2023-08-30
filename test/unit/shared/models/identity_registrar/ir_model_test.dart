import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  group('Tests of IRModel.isEmpty()', () {
    test('Should return [true] if all records are empty', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, true);
    });

    test('Should return [false] if at least one record exists and is not empty (avatarIRRecordModel)', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel(
          id: '1',
          key: 'avatar',
          value: 'https://avatars.githubusercontent.com/u/57797119?v=4',
          verifiersAddresses: <WalletAddress>[],
          irVerificationRequests: <IRVerificationRequestModel>[],
        ),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });

    test('Should return [false] if at least one record exists and is not empty (usernameIRRecordModel)', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel(
          id: '1',
          key: 'username',
          value: 'foobar',
          verifiersAddresses: <WalletAddress>[],
          irVerificationRequests: <IRVerificationRequestModel>[],
        ),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });

    test('Should return [false] if at least one record exists and is not empty (descriptionIRRecordModel)', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel(
          id: '1',
          key: 'description',
          value: 'Hello World',
          verifiersAddresses: <WalletAddress>[],
          irVerificationRequests: <IRVerificationRequestModel>[],
        ),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });

    test('Should return [false] if at least one record exists and is not empty (socialMediaIRRecordModel)', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel(
          id: '1',
          key: 'social',
          value: 'https://github.com/kiracore',
          verifiersAddresses: <WalletAddress>[],
          irVerificationRequests: <IRVerificationRequestModel>[],
        ),
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });

    test('Should return [false] if at least one record exists and is not empty (otherIRRecordModelList)', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
        otherIRRecordModelList: const <IRRecordModel>[
          IRRecordModel(
            id: '1',
            key: 'foo',
            value: 'bar',
            verifiersAddresses: <WalletAddress>[],
            irVerificationRequests: <IRVerificationRequestModel>[],
          ),
        ],
      );

      // Act
      bool actualEmptyBool = actualIrModel.isEmpty();

      // Assert
      expect(actualEmptyBool, false);
    });
  });

  group('Tests of IRModel.name', () {
    test('Should return [username] from identity registrar if [usernameIRRecordModel exists]', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel(
          id: '1',
          key: 'username',
          value: 'foobar',
          verifiersAddresses: <WalletAddress>[],
          irVerificationRequests: <IRVerificationRequestModel>[],
        ),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      String actualName = actualIrModel.name;

      // Assert
      String expectedName = 'foobar';
      expect(actualName, expectedName);
    });

    test('Should return [short bech32 address] if [usernameIRRecordModel NOT exists]', () {
      // Arrange
      IRModel actualIrModel = IRModel(
        walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
        avatarIRRecordModel: const IRRecordModel.empty(key: 'avatar'),
        usernameIRRecordModel: const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
      );

      // Act
      String actualName = actualIrModel.name;

      // Assert
      String expectedName = 'kira143q_k9wx';
      expect(actualName, expectedName);
    });
  });
}
