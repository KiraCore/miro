import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/shared/utils/extensions/date_time_extension.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/blocks_drawer_page/blocks_drawer_page.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/desktop/blocks_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class BlocksListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final BlockModel blockModel;
  final bool isAgeFormatBool;

  const BlocksListItemDesktop({
    required this.blockModel,
    required this.isAgeFormatBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    // TokenAmountModel? totalAmount = txListItemModel.txMsgModels.totalAmount;
    // Set<String> fromAddresses =
    // txListItemModel.txMsgModels.where((ATxMsgModel e) => e.fromAddress != null).map((ATxMsgModel e) => e.fromAddress!.bech32Address).toSet();
    // Set<String> toAddresses =
    // txListItemModel.txMsgModels.where((ATxMsgModel e) => e.toAddress != null).map((ATxMsgModel e) => e.toAddress!.bech32Address).toSet();
    // // TODO(Mykyta): avoid direction type after INTERX updated to getAllTransactions
    // List<String> methods = txListItemModel.txMsgModels.map((ATxMsgModel e) => e.getTitle(context, TxDirectionType.outbound)).toList();
    // if (methods.length > methods.toSet().length) {
    //   for (final String method in methods.toSet()) {
    //     int count = methods.where((String element) => element == method).length;
    //     if (count > 1) {
    //       methods[methods.indexOf(method)] = '${count}x $method';
    //       methods.removeWhere((String element) => element == method);
    //     }
    //   }
    // }
    //
    // return InkWrapper(
    //   onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
    //     TransactionDetailsDrawerPage(txListItemModel: txListItemModel),
    //   ),
    //   child: TransactionListItemDesktopLayout(
    //     height: height,
    //     hashWidget: KiraToolTip(
    //       childMargin: EdgeInsets.zero,
    //       message: txListItemModel.hash,
    //       child: Text(
    //         CryptoAddressParser.stripHexPrefix(txListItemModel.hash),
    //         overflow: TextOverflow.ellipsis,
    //         style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
    //       ),
    //     ),
    //     methodWidget: KiraToolTip(
    //       childMargin: EdgeInsets.zero,
    //       message: methods.join('\n\n'),
    //       child: Text(
    //         methods.join(', '),
    //         overflow: TextOverflow.ellipsis,
    //         style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
    //       ),
    //     ),
    //     dateWidget: Text(
    //       isAgeFormatBool ? txListItemModel.time.toShortAgeAgo(context) : DateFormat('d/M/y, HH:mm').format(txListItemModel.time.toLocal()),
    //       overflow: TextOverflow.ellipsis,
    //       style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
    //     ),
    //     isDateInAgeFormatBool: isAgeFormatBool,
    //     fromWidget: fromAddresses.isEmpty
    //         ? const Text('---')
    //         : KiraToolTip(
    //       childMargin: EdgeInsets.zero,
    //       message: fromAddresses.join('\n\n'),
    //       child: Row(
    //         children: <Widget>[
    //           Expanded(
    //             child: Text(
    //               fromAddresses.first,
    //               overflow: TextOverflow.ellipsis,
    //               style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
    //             ),
    //           ),
    //           if (fromAddresses.length > 1) _Count(count: fromAddresses.length - 1),
    //         ],
    //       ),
    //     ),
    //     toWidget: toAddresses.isEmpty
    //         ? const Text('---')
    //         : KiraToolTip(
    //       childMargin: EdgeInsets.zero,
    //       message: toAddresses.join('\n\n'),
    //       child: Row(
    //         children: <Widget>[
    //           Expanded(
    //             child: Text(
    //               toAddresses.first,
    //               overflow: TextOverflow.ellipsis,
    //               style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
    //             ),
    //           ),
    //           if (toAddresses.length > 1) _Count(count: toAddresses.length - 1),
    //         ],
    //       ),
    //     ),
    //     amountWidget: txListItemModel.txMsgModels.isEmpty || totalAmount == null
    //         ? const Text('---')
    //         : Text(
    //       totalAmount.toString(),
    //       overflow: TextOverflow.ellipsis,
    //       style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
    //     ),
    //     feeWidget: Text(
    //       txListItemModel.fees.reduce((TokenAmountModel count, TokenAmountModel e) => count + e).toString(),
    //       overflow: TextOverflow.ellipsis,
    //       style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
    //     ),
    //   ),
    // );

    return InkWrapper(
      onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(BlocksDrawerPage(
        blockModel: blockModel,
      )),
      child: BlocksListItemDesktopLayout(
        height: height,
        heightWidget: Text(
          blockModel.header.height,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
        ),
        proposerWidget: KiraToolTip(
          childMargin: EdgeInsets.zero,
          message: blockModel.header.proposerAddress,
          child: Row(
            children: <Widget>[
              KiraIdentityAvatar(
                address: blockModel.header.proposerAddress,
                size: 24,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  CryptoAddressParser.stripHexPrefix(blockModel.header.proposerAddress),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                ),
              ),
            ],
          ),
        ),
        hashWidget: KiraToolTip(
          childMargin: EdgeInsets.zero,
          message: blockModel.blockId.hash,
          child: Text(
            CryptoAddressParser.stripHexPrefix(blockModel.blockId.hash),
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
          ),
        ),
        ageWidget: Text(
          isAgeFormatBool
              ? blockModel.header.time.toShortAgeAgo(context)
              : DateFormat('d/M/y, HH:mm').format(blockModel.header.time.toLocal()),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
        ),
        isDateInAgeFormatBool: isAgeFormatBool,
        txCountWidget: Text(
          blockModel.numTxs.toString(),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
        ),
      ),
    );
  }
}
