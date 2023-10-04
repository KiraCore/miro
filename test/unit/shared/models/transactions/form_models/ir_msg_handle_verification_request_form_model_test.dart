import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_handle_verification_request_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  WalletAddress actualSenderAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  IRInboundVerificationRequestModel actualIrVerificationRequestModel = IRInboundVerificationRequestModel(
    id: '3',
    tipTokenAmountModel: TokenAmountModel(lowestDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
    dateTime: DateTime.parse('2021-09-30 12:00:00'),
    requesterIrUserProfileModel: IRUserProfileModel(
      walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
      username: 'somnitear',
      avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
    ),
    records: <String, String>{
      'key1': 'value1',
      'key2': 'value2',
    },
  );

  group('Tests of IRMsgHandleVerificationRequestFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: true,
        walletAddress: actualSenderAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgHandleVerificationRequestFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (approvalStatusBool)', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: null,
        walletAddress: actualSenderAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgHandleVerificationRequestFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields not exists (walletAddress)', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: true,
        walletAddress: null,
      );

      // Act
      bool actualBuildAvailableBool = actualIrMsgHandleVerificationRequestFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of IRMsgHandleVerificationRequestFormModel.buildTxMsgModel()', () {
    test('Should [return IRMsgHandleVerificationRequestModel] if all required form fields are filled', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: true,
        walletAddress: actualSenderAddress,
      );

      // Act
      ATxMsgModel actualIrMsgHandleVerificationRequestModel = actualIrMsgHandleVerificationRequestFormModel.buildTxMsgModel();

      // Assert
      IRMsgHandleVerificationRequestModel expectedIrMsgHandleVerificationRequestModel = IRMsgHandleVerificationRequestModel(
        approvalStatusBool: true,
        verifyRequestId: '3',
        walletAddress: actualSenderAddress,
      );

      expect(actualIrMsgHandleVerificationRequestModel, expectedIrMsgHandleVerificationRequestModel);
    });

    test('Should [throw Exception] if at least one of required form fields not exists (approvalStatusBool)', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: null,
        walletAddress: actualSenderAddress,
      );

      // Assert
      expect(
        () => actualIrMsgHandleVerificationRequestFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields not exists (walletAddress)', () {
      // Arrange
      IRMsgHandleVerificationRequestFormModel actualIrMsgHandleVerificationRequestFormModel = IRMsgHandleVerificationRequestFormModel(
        irInboundVerificationRequestModel: actualIrVerificationRequestModel,
        approvalStatusBool: true,
        walletAddress: null,
      );

      // Assert
      expect(
        () => actualIrMsgHandleVerificationRequestFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
