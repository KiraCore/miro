import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

Future<void> main() async {
  AWalletAddress actualDelegatorWalletAddress = AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  String actualValkey = 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7';
  List<TokenAmountModel> actualTokenAmountModels = <TokenAmountModel>[
    TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(100),
      tokenAliasModel: TokenAliasModel.local('ukex'),
    ),
  ];

  group('Tests of StakingMsgDelegateFormModel.buildTxMsgModel()', () {
    test('Should [return MsgSendModel] if all required form fields are filled', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Act
      ATxMsgModel actualMsgSendModel = actualStakingMsgDelegateFormModel.buildTxMsgModel();

      // Assert
      StakingMsgDelegateModel expectedStakingMsgDelegateModel = StakingMsgDelegateModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: actualTokenAmountModels,
      );

      expect(actualMsgSendModel, expectedStakingMsgDelegateModel);
    });

    test('Should [throw Exception] if all required form fields are filled, but amount is equal "0"', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: <TokenAmountModel>[
          TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(0),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ],
      );

      // Assert
      expect(
        () => actualStakingMsgDelegateFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (delegatorWalletAddress)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: null,
        valkey: actualValkey,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Assert
      expect(
        () => actualStakingMsgDelegateFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (valkey)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: null,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Assert
      expect(
        () => actualStakingMsgDelegateFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if at least one of required form fields is empty (tokenAmountModels)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: null,
      );

      // Assert
      expect(
        () => actualStakingMsgDelegateFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('Tests of StakingMsgDelegateFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if all required form fields are filled', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgDelegateFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if all required form fields are filled, but amount is equal "0"', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: <TokenAmountModel>[
          TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(0),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ],
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgDelegateFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (delegatorWalletAddress)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: null,
        valkey: actualValkey,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgDelegateFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (valkey)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: null,
        tokenAmountModels: actualTokenAmountModels,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgDelegateFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if at least one of required form fields is empty (tokenAmountModels)', () {
      // Arrange
      StakingMsgDelegateFormModel actualStakingMsgDelegateFormModel = StakingMsgDelegateFormModel(
        delegatorWalletAddress: actualDelegatorWalletAddress,
        valkey: actualValkey,
        tokenAmountModels: null,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgDelegateFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });
}
