import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_cancel_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_rewards_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_undelegation_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_undelegate_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/query_transactions_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryTransactionsService actualQueryTransactionsService = globalLocator<QueryTransactionsService>();

  PageData<TxListItemModel> expectedTransactionsPageData = PageData<TxListItemModel>(
    lastPageBool: false,
    blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
    cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
    listItems: <TxListItemModel>[
      // MsgSend inbound
      TxListItemModel(
        hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
        time: DateTime.parse('2023-01-30 15:48:28.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('samolean')),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
            fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('samolean')),
          ),
        ],
      ),
      // MsgSend outbound
      TxListItemModel(
        hash: '0x5372F94173105AE3DE4A19CA30A02F1590437F823D45E43EAFC589199C2BC2A2',
        time: DateTime.parse('2022-12-27 12:11:46.000Z'),
        txDirectionType: TxDirectionType.inbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(500), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.add,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(20000000), tokenAliasModel: TokenAliasModel.local('test')),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          MsgSendModel(
            fromWalletAddress: WalletAddress.fromBech32('kira1m82gva4kqj28ulnk02a8447uumdl26jyegsca4'),
            toWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(20000000), tokenAliasModel: TokenAliasModel.local('test')),
          ),
        ],
      ),
      // MsgRegisterIdentityRecords
      TxListItemModel(
        hash: '0x99BA327FE4299E6654BDD082E147A2C58A5DC513DB754A3A78EB3960142613BB',
        time: DateTime.parse('2023-01-02 10:37:10.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        txMsgModels: <ATxMsgModel>[
          IRMsgRegisterRecordsModel(
            irEntryModels: const <IREntryModel>[
              IREntryModel(key: 'avatar', info: 'https://paganresearch.io/images/kiracore.jpg'),
            ],
            walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          ),
        ],
      ),
      // MsgRequestIdentityRecordsVerify
      TxListItemModel(
        hash: '0x529CF7D991FE7C9FDF115378AD3559AB18EC5DA8C4CF29EC1EC525E01720238B',
        time: DateTime.parse('2023-01-02 10:44:36.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
          ),
        ],
        txMsgModels: <ATxMsgModel>[
          IRMsgRequestVerificationModel(
            recordIds: <BigInt>[BigInt.from(2)],
            tipTokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
            verifierWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          ),
        ],
      ),
      // MsgCancelIdentityRecordsVerifyRequest
      TxListItemModel(
        hash: '0x25FD76956C6C1BD814E9376D78BE87511E41ABA1F24264AF455EEC600CB1961B',
        time: DateTime.parse('2023-01-02 10:46:06.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        txMsgModels: <ATxMsgModel>[
          IRMsgCancelVerificationRequestModel(
            verifyRequestId: BigInt.from(1),
            walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          ),
        ],
      ),
      // MsgDeleteIdentityRecords
      TxListItemModel(
        hash: '0xFAB7C1AC4E8CF8C87D3100B6F601151C77927997B103940E9995DA1207C0E032',
        time: DateTime.parse('2023-01-02 10:51:02.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        txMsgModels: <ATxMsgModel>[
          IRMsgDeleteRecordsModel(
            keys: const <String>['website'],
            walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
          ),
        ],
      ),
      // MsgHandleIdentityRecordsVerifyRequest
      TxListItemModel(
        hash: '0x2114D4CE6A7F85F798A6B4B44AEE2E639CCEE7551152D51367ABD4DC95154D0F',
        time: DateTime.parse('2023-01-02 15:49:23.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(200), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        txMsgModels: <ATxMsgModel>[
          IRMsgHandleVerificationRequestModel(
            approvalStatusBool: true,
            verifyRequestId: '4',
            walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          ),
        ],
      ),
      // MsgDelegate
      TxListItemModel(
        hash: '0x3ADE47F67589A9B8FE75F9E669BBB2FA49B1B010525BD54C75D2F8E94A970F07',
        time: DateTime.parse('2023-01-02 15:49:24.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        txMsgModels: <ATxMsgModel>[
          StakingMsgDelegateModel(
            delegatorWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
            tokenAmountModels: <TokenAmountModel>[
              TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex'))
            ],
          ),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.subtract,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
          ),
        ],
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
      ),
      // MsgUndelegate
      TxListItemModel(
        hash: '0x72873A65DA27D3B1E967EA2BA5364A69BB8C52E8EBB74C599356DEE279543B1A',
        time: DateTime.parse('2023-01-02 15:49:25.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        txMsgModels: <ATxMsgModel>[
          StakingMsgUndelegateModel(
            delegatorWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            valkey: 'kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7',
            tokenAmountModels: <TokenAmountModel>[
              TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex'))
            ],
          ),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[
          PrefixedTokenAmountModel(
            tokenAmountPrefixType: TokenAmountPrefixType.add,
            tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
          ),
        ],
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
      ),
      // MsgClaimRewards
      TxListItemModel(
        hash: '0x1B3CB7CCBAD84FAAF28F9481B376309B0D63249A466571D6CCDF5FD5C8044434',
        time: DateTime.parse('2023-01-02 15:49:26.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        txMsgModels: <ATxMsgModel>[StakingMsgClaimRewardsModel(senderWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'))],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
      ),
      // MsgClaimUndelegation
      TxListItemModel(
        hash: '0xEB41A34FC3B56EDB29743431C8816F6F33D3C7C0C649DB9E9A3784D9B9EE5FA0',
        time: DateTime.parse('2023-01-02 15:49:27.000Z'),
        txDirectionType: TxDirectionType.outbound,
        txStatusType: TxStatusType.confirmed,
        txMsgModels: <ATxMsgModel>[
          StakingMsgClaimUndelegationModel(
            senderWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            undelegationId: '1',
          ),
        ],
        prefixedTokenAmounts: <PrefixedTokenAmountModel>[],
        fees: <TokenAmountModel>[
          TokenAmountModel(defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TokenAliasModel.local('ukex')),
        ],
      ),
    ],
  );

  group('Tests of QueryTransactionsService.getTransactionList() method', () {
    test('Should return [PageData<TxListItemModel>] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(
        address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        limit: 10,
        offset: 0,
      );

      // Act
      PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

      //Assert
      expect(actualTransactionsPageData, expectedTransactionsPageData);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

      // Assert
      expect(
        () => actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

      // Assert
      expect(
        () => actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
