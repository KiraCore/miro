import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/transactions_list_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_transactions.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_tx.dart';
import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_transactions.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_tx.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/list/sorting_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/pages/transactions_comparator.dart';
import 'package:miro/test/test_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/lists/transactions_list_bloc_test.dart --platform chrome
Future<void> main() async {
  // Actual values for tests
  final NetworkModel actualNetworkModel = NetworkModel(
    name: 'online.kira.network',
    url: 'https://online.kira.network',
    status: NetworkHealthStatus.unknown,
  );

  // Expected values for tests
  Set<TransactionObject> expectedAllTransactionsDateAsc = <TransactionObject>{
    WithdrawsTransactions(
      hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
      time: 1648643551,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
      time: 1648643515,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
      time: 1648643463,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
      ],
    ),
    WithdrawsTransactions(
      hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
      time: 1648643276,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
      ],
    ),
    WithdrawsTransactions(
      hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
      time: 1648643106,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
      ],
    ),
    WithdrawsTransactions(
      hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
      time: 1648642933,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
      time: 1648642903,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
      ],
    ),
    WithdrawsTransactions(
      hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
      time: 1648232615,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
      ],
    ),
    WithdrawsTransactions(
      hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
      time: 1648136702,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
      time: 1648136612,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
      ],
    ),
    DepositsTransactions(
      hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
      time: 1648130242,
      txs: <DepositsTx>[
        DepositsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
      ],
    ),
    DepositsTransactions(
      hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
      time: 1648069106,
      txs: <DepositsTx>[
        DepositsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
      ],
    )
  };

  // Init tests
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  globalLocator<WalletProvider>().updateWallet(
    SaifuWallet.fromAddress(
      address: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    ),
  );
  globalLocator<NetworkProvider>().handleEvent(ConnectToNetworkEvent(actualNetworkModel));
  globalLocator<NetworkProvider>().handleEvent(SetUpNetworkEvent(actualNetworkModel));

  TransactionsListBloc transactionsListBloc = TransactionsListBloc(
    networkProvider: globalLocator<NetworkProvider>(),
    depositsService: globalLocator<DepositsService>(),
    withdrawsService: globalLocator<WithdrawsService>(),
    walletProvider: globalLocator<WalletProvider>(),
  )..add(InitListEvent());

  // Wait for download list data
  await Future<void>.delayed(const Duration(seconds: 1));

  group('Tests of initList() method', () {
    test('Should return ListLoadedState with first page data', () {
      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
          time: 1648643551,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
          time: 1648643515,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
          time: 1648643463,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
          time: 1648643276,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
          time: 1648643106,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
          time: 1648642933,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
          time: 1648642903,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
          time: 1648136702,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
          time: 1648136612,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
          ],
        ),
      };

      expect(
        transactionsListBloc.state,
        ListLoadedState<TransactionObject>(
          currentPageIndex: 0,
          maxPagesIndex: 1,
          listEndStatus: false,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: expectedAllTransactionsDateAsc,
        ),
      );
    });
  });

  group('Tests of method GoToPageEvent()', () {
    test('Should return ListLoadedState with second page data', () async {
      transactionsListBloc.add(GoToPageEvent(1));
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
          time: 1648643551,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
          time: 1648643515,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
          time: 1648643463,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
          time: 1648643276,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
          time: 1648643106,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
          time: 1648642933,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
          time: 1648642903,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
          time: 1648136702,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
          time: 1648136612,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
          ],
        ),
      };

      Set<TransactionObject> expectedSecondPageItems = <TransactionObject>{
        DepositsTransactions(
          hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
          time: 1648130242,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        DepositsTransactions(
          hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
          time: 1648069106,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
          ],
        )
      };

      expect(
        transactionsListBloc.state,
        ListSortedState<TransactionObject>(
          currentPageIndex: 1,
          maxPagesIndex: 1,
          listEndStatus: true,
          itemsFromStart: <TransactionObject>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllTransactionsDateAsc,
        ),
      );
    });
  });

  group('Tests of method SortEvent()', () {
    test('Should return ListSortedState with items sorted by date descending', () async {
      transactionsListBloc.add(
        SortEvent<TransactionObject>(
          TransactionsComparator().getSortOption(TransactionSortOption.date).copyWith(
                sortingStatus: SortingStatus.desc,
              ),
        ),
      );
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
          time: 1648643551,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
          time: 1648643515,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
          time: 1648643463,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
          time: 1648643276,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
          time: 1648643106,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
          time: 1648642933,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
          time: 1648642903,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
          time: 1648136702,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
          time: 1648136612,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
          ],
        ),
      };

      Set<TransactionObject> expectedSecondPageItems = <TransactionObject>{
        DepositsTransactions(
          hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
          time: 1648130242,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        DepositsTransactions(
          hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
          time: 1648069106,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
          ],
        )
      };

      expect(
        transactionsListBloc.state,
        ListSortedState<TransactionObject>(
          currentPageIndex: 1,
          maxPagesIndex: 1,
          listEndStatus: true,
          itemsFromStart: <TransactionObject>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllTransactionsDateAsc.toList().reversed.toSet(),
        ),
      );
    });

    test('Should return ListSortedState with items sorted by date ascending', () async {
      transactionsListBloc.add(
        SortEvent<TransactionObject>(
          TransactionsComparator().getSortOption(TransactionSortOption.date).copyWith(
                sortingStatus: SortingStatus.asc,
              ),
        ),
      );
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        DepositsTransactions(
          hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
          time: 1648069106,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
          ],
        ),
        DepositsTransactions(
          hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
          time: 1648130242,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
          time: 1648136612,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
          time: 1648136702,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
          time: 1648642903,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
          time: 1648642933,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
          time: 1648643106,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
          time: 1648643276,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
          time: 1648643463,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
      };

      Set<TransactionObject> expectedSecondPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
          time: 1648643515,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
          time: 1648643551,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
      };

      expect(
        transactionsListBloc.state,
        ListSortedState<TransactionObject>(
          currentPageIndex: 1,
          maxPagesIndex: 1,
          listEndStatus: true,
          itemsFromStart: <TransactionObject>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllTransactionsDateAsc.toList().reversed.toSet(),
        ),
      );
    });
  });

  group('Tests of AddFilterEvent()', () {
    test('Should return Deposits list only', () async {
      transactionsListBloc.add(
        AddFilterEvent<TransactionObject>(
          TransactionsComparator().getFilterOption(TransactionFilterOption.deposits),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        DepositsTransactions(
          hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
          time: 1648069106,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
          ],
        ),
        DepositsTransactions(
          hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
          time: 1648130242,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
      };

      expect(
        transactionsListBloc.state,
        ListFilteredState<TransactionObject>(
          currentPageIndex: 0,
          maxPagesIndex: 0,
          listEndStatus: true,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: <TransactionObject>{
            ...expectedFirstPageItems,
          },
        ),
      );
    });

    test('Should return Deposits and Withdraws list', () async {
      transactionsListBloc.add(
        AddFilterEvent<TransactionObject>(
          TransactionsComparator().getFilterOption(TransactionFilterOption.withdraws),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        DepositsTransactions(
          hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
          time: 1648069106,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
          ],
        ),
        DepositsTransactions(
          hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
          time: 1648130242,
          txs: <DepositsTx>[
            DepositsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC207DCCCFF051B2786F180FC05CFEAA4728937E41F713387C424AF7BE2136319',
          time: 1648136612,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x6B0FBB24BF3E9EE4691EFF7348A6FAADFF7A5CAC5ADCB5ACFA73F21CB2899C0B',
          time: 1648136702,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 255),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xC26496E0CC1DF3D274F2ADE8376FF32885DF8DAF4E48EF4AEB25068E1247AF48',
          time: 1648642903,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 784),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x16B87A70EF70B1D2B706DF8E5148C137CB596DF8F1EDA800DC205DB3551C7651',
          time: 1648642933,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 111),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x792981E97C47261D94639E9F3B63EF30CB761E2CE5DDC78901AF1FB768293E19',
          time: 1648643106,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 112),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x0AC411701EAA1947146F46A8012A288595A0EF17C5D0896AB7F00600D2A6FED7',
          time: 1648643276,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
          time: 1648643463,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
      };

      Set<TransactionObject> expectedSecondPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
          time: 1648643515,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
        WithdrawsTransactions(
          hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
          time: 1648643551,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 100),
          ],
        ),
      };

      expect(
        transactionsListBloc.state,
        ListFilteredState<TransactionObject>(
          currentPageIndex: 0,
          maxPagesIndex: 1,
          listEndStatus: false,
          itemsFromStart: <TransactionObject>{
            ...expectedFirstPageItems,
          },
          pageListItems: expectedFirstPageItems,
          allListItems: <TransactionObject>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
        ),
      );
    });
  });

  group('Tests of SearchEvent()', () {
    test('Should return Transactions matching the given search pattern', () async {
      transactionsListBloc.add(
        SearchEvent<TransactionObject>(
          (TransactionObject item) => TransactionsComparator.filterSearch(item, '123'),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<TransactionObject> expectedFirstPageItems = <TransactionObject>{
        WithdrawsTransactions(
          hash: '0x68D90EF8C14E51055575FE80B67C504F60599F26E8AAB89CDC343A94BCB4C66F',
          time: 1648232615,
          txs: <WithdrawsTx>[
            WithdrawsTx(
                address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 123)
          ],
        ),
      };

      expect(
        transactionsListBloc.state,
        ListSearchedState<TransactionObject>(
          currentPageIndex: 0,
          maxPagesIndex: 0,
          listEndStatus: true,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: <TransactionObject>{
            ...expectedFirstPageItems,
          },
        ),
      );
    });
  });
}
