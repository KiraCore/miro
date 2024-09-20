import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/transactions/tx_list_item_model_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of TxListItemModel.isOutbound getter', () {
    test('Should return [true] if txDirectionType is equal [TxDirectionType.outbound]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Assert
      expect(actualTxListItemModel.isOutbound, true);
    });

    test('Should return [false] if txDirectionType is equal [TxDirectionType.inbound]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.inbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Assert
      expect(actualTxListItemModel.isOutbound, false);
    });
  });

  group('Tests of TxListItemModel.txMsgType getter', () {
    test('Should return [TxMsgType.undefined] if TxListItemModel [NOT contains any transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[],
      );

      // Act
      TxMsgType actualTxMsgType = actualTxListItemModel.txMsgType;

      // Assert
      TxMsgType expectedTxMsgType = TxMsgType.undefined;

      expect(actualTxMsgType, expectedTxMsgType);
    });

    test('Should return [corresponding tx type] if TxListItemModel [contains ONE transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Act
      TxMsgType actualTxMsgType = actualTxListItemModel.txMsgType;

      // Assert
      TxMsgType expectedTxMsgType = TxMsgType.msgSend;

      expect(actualTxMsgType, expectedTxMsgType);
    });

    test('Should return [TxMsgType.multiple] if TxListItemModel [contains MORE THAN ONE transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Act
      TxMsgType actualTxMsgType = actualTxListItemModel.txMsgType;

      // Assert
      TxMsgType expectedTxMsgType = TxMsgType.multiple;

      expect(actualTxMsgType, expectedTxMsgType);
    });
  });

  group('Tests of TxListItemModel.isMultiTransaction getter', () {
    test('Should return [false] if TxListItemModel [NOT contains any transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[],
      );

      // Assert
      expect(actualTxListItemModel.isMultiTransaction, false);
    });

    test('Should return [false] if TxListItemModel [contains ONE transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Assert
      expect(actualTxListItemModel.isMultiTransaction, false);
    });

    test('Should return [true] if TxListItemModel [contains MORE THAN ONE transaction]', () {
      // Arrange
      TxListItemModel actualTxListItemModel = TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 16:48:28.000'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
          MsgSendModel(
              fromWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              toWalletAddress: AWalletAddress.fromAddress('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
              tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
        ],
      );

      // Assert
      expect(actualTxListItemModel.isMultiTransaction, true);
    });
  });
}
