import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/query_transaction_result_resp.dart';
import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/models/list/sorting_status.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/pages/transactions_comparator.dart';

class TransactionsListBloc extends ListBloc<TransactionObject> {
  final WithdrawsService withdrawsService;
  final DepositsService depositsService;
  final WalletProvider walletProvider;

  final Map<String, QueryTransactionResultResp> transactionsStatus = <String, QueryTransactionResultResp>{};

  TransactionsListBloc({
    required NetworkProvider networkProvider,
    required this.withdrawsService,
    required this.depositsService,
    required this.walletProvider,
  }) : super(networkProvider: networkProvider) {
    walletProvider.addListener(() => add(RefreshListEvent()));
  }

  TransactionsListBloc.init({
    required NetworkProvider networkProvider,
    required this.withdrawsService,
    required this.depositsService,
    required this.walletProvider,
  }) : super.init(networkProvider: networkProvider) {
    walletProvider.addListener(() => add(RefreshListEvent()));
  }

  @override
  SortOption<TransactionObject> get defaultSortOption =>
      TransactionsComparator().getSortOption(TransactionSortOption.date).copyWith(
            sortingStatus: SortingStatus.desc,
          );

  @override
  Future<Set<TransactionObject>> downloadListData() async {
    if (!walletProvider.isLoggedIn) {
      AppLogger().log(message: 'User not logged in');
      return <TransactionObject>{};
    }
    Set<TransactionObject> transactionObjects = <TransactionObject>{
      ...await _fetchWithdraws(),
      ...await _fetchDeposits(),
    };
    return transactionObjects;
  }

  Future<Set<TransactionObject>> _fetchWithdraws() async {
    try {
      String walletAddress = walletProvider.currentWallet!.address.bech32Address;
      WithdrawsResp withdrawsResp = (await withdrawsService.getAccountWithdraws(WithdrawsReq(account: walletAddress)))!;
      return withdrawsResp.transactions.toSet();
    } catch (e) {
      AppLogger().log(message: 'Network error while fetching Withdraws: $e');
      return <TransactionObject>{};
    }
  }

  Future<Set<TransactionObject>> _fetchDeposits() async {
    try {
      String walletAddress = walletProvider.currentWallet!.address.bech32Address;
      DepositsResp depositsResp = (await depositsService.getAccountDeposits(DepositsReq(account: walletAddress)))!;
      return depositsResp.transactions.toSet();
    } catch (e) {
      AppLogger().log(message: 'Network error while fetching Deposits: $e');
      return <TransactionObject>{};
    }
  }
}
