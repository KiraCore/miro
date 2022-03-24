import 'package:miro/infra/dto/api/deposits/response/deposits_transactions.dart';
import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_transactions.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/utils/date_time_utils.dart';
import 'package:miro/shared/utils/pages/list_items_comparator.dart';
import 'package:miro/shared/utils/string_utils.dart';

enum TransactionSortOption {
  date,
  details,
  hash,
  amount,
}

enum TransactionFilterOption {
  date,
  withdraws,
  deposits,
}

class TransactionsComparator
    extends ListItemsComparator<TransactionFilterOption, TransactionSortOption, TransactionObject> {
  @override
  Map<TransactionSortOption, SortOption<TransactionObject>> sortOptions =
      const <TransactionSortOption, SortOption<TransactionObject>>{
    TransactionSortOption.date: SortOption<TransactionObject>(
      name: 'Date',
      comparator: _sortByDate,
    ),
    TransactionSortOption.details: SortOption<TransactionObject>(
      name: 'Details',
      comparator: _sortByDetails,
    ),
    TransactionSortOption.hash: SortOption<TransactionObject>(
      name: 'Transaction hash',
      comparator: _sortByHash,
    ),
    TransactionSortOption.amount: SortOption<TransactionObject>(
      name: 'Amount',
      comparator: _sortByAmount,
    ),
  };

  @override
  Map<TransactionFilterOption, FilterOption<TransactionObject>> filterOptions =
      const <TransactionFilterOption, FilterOption<TransactionObject>>{
    TransactionFilterOption.withdraws: FilterOption<TransactionObject>(
      name: 'Withdraws',
      comparator: _filterByWithdraws,
    ),
    TransactionFilterOption.deposits: FilterOption<TransactionObject>(
      name: 'Deposits',
      comparator: _filterByDeposits,
    ),
  };

  static int _sortByDate(TransactionObject a, TransactionObject b) {
    try {
      return a.time.compareTo(b.time);
    } catch (_) {
      return 0;
    }
  }

  static int _sortByDetails(TransactionObject a, TransactionObject b) {
    try {
      return a.txs.first.address.compareTo(b.txs.first.address);
    } catch (_) {
      return 0;
    }
  }

  static int _sortByHash(TransactionObject a, TransactionObject b) {
    try {
      return a.hash.compareTo(b.hash);
    } catch (_) {
      return 0;
    }
  }

  static int _sortByAmount(TransactionObject a, TransactionObject b) {
    try {
      return a.txs.first.amount.compareTo(b.txs.first.amount);
    } catch (_) {
      return 0;
    }
  }

  static bool _filterByWithdraws(TransactionObject item) {
    return item is WithdrawsTransactions;
  }

  static bool _filterByDeposits(TransactionObject item) {
    return item is DepositsTransactions;
  }

  static bool filterByDate(TransactionObject item, DateTime? from, DateTime? to) {
    if (from == null || to == null) {
      return false;
    }
    try {
      DateTime date = CustomDateTime.fromSeconds(item.time);
      bool isBetween = date.isAfter(from) && date.isBefore(to);
      bool isEqual = DateTimeUtils.isTheSameDay(date, from) || DateTimeUtils.isTheSameDay(date, to);
      return isBetween || isEqual;
    } catch (_) {
      return false;
    }
  }

  static bool filterSearch(TransactionObject item, String searchValue) {
    bool searchAddressStatus = StringUtils.compareStrings(item.txs.first.address, searchValue);
    bool searchDenomStatus = StringUtils.compareStrings(item.txs.first.denom, searchValue);
    bool searchAmountStatus = StringUtils.compareStrings(item.txs.first.amount.toString(), searchValue);
    bool searchHashStatus = StringUtils.compareStrings(item.hash, searchValue);
    return searchAmountStatus || searchDenomStatus || searchAddressStatus || searchHashStatus;
  }
}
