import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/mobile/transaction_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionListItemBuilder extends StatelessWidget {
  final TxListItemModel txListItemModel;
  final WalletAddressType walletAddressType;

  const TransactionListItemBuilder({
    required this.txListItemModel,
    required this.walletAddressType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget desktopWidget = TransactionListItemDesktop(txListItemModel: txListItemModel, walletAddressType: walletAddressType);
    Widget mobileWidget = TransactionListItemMobile(txListItemModel: txListItemModel, walletAddressType: walletAddressType);

    return ResponsiveWidget(
      largeScreen: desktopWidget,
      mediumScreen: mobileWidget,
      smallScreen: mobileWidget,
    );
  }
}
