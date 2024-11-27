import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class TransactionsFilterOptions {
  static FilterOption<TxListItemModel> filterBySendMethod = FilterOption<TxListItemModel>(
    id: 'send',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgSend),
  );

  static FilterOption<TxListItemModel> filterByDelegateMethod = FilterOption<TxListItemModel>(
    id: 'delegate',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgDelegate),
  );

  static FilterOption<TxListItemModel> filterByUndelegateMethod = FilterOption<TxListItemModel>(
    id: 'undelegate',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgUndelegate),
  );

  static FilterOption<TxListItemModel> filterByDeleteIdentityRecordsMethod = FilterOption<TxListItemModel>(
    id: 'delete-identity-records',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgDeleteIdentityRecords),
  );

  static FilterOption<TxListItemModel> filterByHandleIdentityRecordsVerifyRequestMethod = FilterOption<TxListItemModel>(
    id: 'handle-identity-records-verify-request',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgHandleIdentityRecordsVerifyRequest),
  );

  static FilterOption<TxListItemModel> filterByRegisterIdentityMethod = FilterOption<TxListItemModel>(
    id: 'register-identity-records',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgRegisterIdentityRecords),
  );

  static FilterOption<TxListItemModel> filterByCancelIdentityMethod = FilterOption<TxListItemModel>(
    id: 'cancel-identity-records-verify-request',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgCancelIdentityRecordsVerifyRequest),
  );

  static FilterOption<TxListItemModel> filterByClaimRewardsMethod = FilterOption<TxListItemModel>(
    id: 'claim-rewards',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgClaimRewards),
  );

  static FilterOption<TxListItemModel> filterByClaimUndelegationMethod = FilterOption<TxListItemModel>(
    id: 'claim-undelegation',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgClaimUndelegation),
  );

  static FilterOption<TxListItemModel> filterByRequestIdentityRecordsVerifyMethod = FilterOption<TxListItemModel>(
    id: 'request-identity-records-verify',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.msgRequestIdentityRecordsVerify),
  );

  static FilterOption<TxListItemModel> filterByUndefinedMethod = FilterOption<TxListItemModel>(
    id: 'undefined',
    filterComparator: (TxListItemModel a) => _hasMessageTypeInside(a, TxMsgType.undefined),
  );

  static bool _hasMessageTypeInside(TxListItemModel txListItemModel, TxMsgType desiredType) {
    if (txListItemModel.txMsgType == TxMsgType.undefined && desiredType != TxMsgType.undefined) {
      return false;
    }
    return txListItemModel.txMsgModels.any((ATxMsgModel model) => model.txMsgType == desiredType);
  }

  static FilterComparator<TxListItemModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (TxListItemModel item) {
      bool hashMatch = item.hash.toLowerCase().contains(pattern);
      bool fromMatch = item.txMsgModels.isNotEmpty && (item.txMsgModels.first.fromAddress?.bech32Address.toLowerCase().contains(pattern) ?? false);
      bool toMatch = item.txMsgModels.isNotEmpty && (item.txMsgModels.first.toAddress?.bech32Address.toLowerCase().contains(pattern) ?? false);
      return hashMatch || fromMatch || toMatch;
    };
  }
}
