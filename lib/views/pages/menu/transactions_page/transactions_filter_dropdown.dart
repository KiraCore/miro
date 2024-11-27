import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_filter_options.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class TransactionsFilterDropdown extends StatelessWidget {
  final List<dynamic> activeFilters;
  final ValueChanged<List<dynamic>> onFiltersChanged;
  final Widget? mobileAdditionalWidget;

  const TransactionsFilterDropdown({
    required this.activeFilters,
    required this.onFiltersChanged,
    this.mobileAdditionalWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FilterOptionModel<TxListItemModel>> filterOptionModels = <FilterOptionModel<TxListItemModel>>[];

    for (TxMsgType type in TxMsgType.values) {
      switch (type) {
        case TxMsgType.msgCancelIdentityRecordsVerifyRequest:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgCancelIdentityRecordsVerifyRequest,
            filterOption: TransactionsFilterOptions.filterByCancelIdentityMethod,
          ));
        case TxMsgType.msgClaimRewards:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgClaimRewards,
            filterOption: TransactionsFilterOptions.filterByClaimRewardsMethod,
          ));
        case TxMsgType.msgClaimUndelegation:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgClaimUndelegation,
            filterOption: TransactionsFilterOptions.filterByClaimUndelegationMethod,
          ));
        case TxMsgType.msgDelegate:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgDelegate,
            filterOption: TransactionsFilterOptions.filterByDelegateMethod,
          ));
        case TxMsgType.msgDeleteIdentityRecords:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgDeleteIdentityRecords,
            filterOption: TransactionsFilterOptions.filterByDeleteIdentityRecordsMethod,
          ));
        case TxMsgType.msgHandleIdentityRecordsVerifyRequest:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgHandleIdentityRecordsVerifyRequest,
            filterOption: TransactionsFilterOptions.filterByHandleIdentityRecordsVerifyRequestMethod,
          ));
        case TxMsgType.msgRegisterIdentityRecords:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgRegisterIdentityRecords,
            filterOption: TransactionsFilterOptions.filterByRegisterIdentityMethod,
          ));
        case TxMsgType.msgRequestIdentityRecordsVerify:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgRequestIdentityRecordsVerify,
            filterOption: TransactionsFilterOptions.filterByRequestIdentityRecordsVerifyMethod,
          ));
        case TxMsgType.msgSend:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgSendSendTokens,
            filterOption: TransactionsFilterOptions.filterBySendMethod,
          ));
        case TxMsgType.msgUndelegate:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgUndelegate,
            filterOption: TransactionsFilterOptions.filterByUndelegateMethod,
          ));
        case TxMsgType.undefined:
          filterOptionModels.add(FilterOptionModel<TxListItemModel>(
            title: S.of(context).txMsgUndefined,
            filterOption: TransactionsFilterOptions.filterByUndefinedMethod,
          ));
        case TxMsgType.multiple:
          break;
      }
    }

    return FilterDropdown<TxListItemModel>(
      title: S.of(context).txListMethod,
      filterOptionModels: filterOptionModels,
    );
  }
}
