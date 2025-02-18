import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/blocks_drawer_page/blocks_drawer_page.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class BlocksListItemMobile extends StatelessWidget {
  final BlockModel blockModel;
  final bool isAgeFormatBool;

  const BlocksListItemMobile({
    required this.blockModel,
    required this.isAgeFormatBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle textStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWrapper(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
          BlocksDrawerPage(blockModel: blockModel),
        ),
        padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 26),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: DesignColors.black,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: PrefixedWidget(
                    prefix: S.of(context).blocksProposer,
                    child: Row(
                      children: <Widget>[
                        CopyButton(
                          value: blockModel.header.proposerAddress,
                          notificationText: S.of(context).toastSuccessfullyCopied,
                        ),
                        const SizedBox(width: 6),
                        KiraIdentityAvatar(
                          address: blockModel.header.proposerAddress,
                          size: 24,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: KiraToolTip(
                            childMargin: EdgeInsets.zero,
                            message: blockModel.header.proposerAddress,
                            child: Text(
                              CryptoAddressParser.stripHexPrefix(blockModel.header.proposerAddress),
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrefixedWidget(
                    prefix: S.of(context).blocksHash,
                    child: Row(
                      children: <Widget>[
                        CopyButton(
                          value: blockModel.blockId.hash,
                          notificationText: S.of(context).toastSuccessfullyCopied,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: KiraToolTip(
                            childMargin: EdgeInsets.zero,
                            message: blockModel.blockId.hash,
                            child: Text(
                              CryptoAddressParser.stripHexPrefix(blockModel.blockId.hash),
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: PrefixedWidget(
                    prefix: S.of(context).blocksHeight,
                    child: Row(
                      children: <Widget>[
                        CopyButton(
                          value: blockModel.header.height,
                          notificationText: S.of(context).toastSuccessfullyCopied,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: KiraToolTip(
                            childMargin: EdgeInsets.zero,
                            message: blockModel.header.height,
                            child: Text(
                              blockModel.header.height,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: PrefixedWidget(
                    prefix: S.of(context).blocksTxCount,
                    child: Text(
                      blockModel.numTxs.toString(),
                      style: textStyle,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: PrefixedWidget(
                    prefix: S.of(context).blocksDate,
                    child: Text(
                      DateFormat('d MMM y, HH:mm:ss').format(blockModel.header.time.toLocal()),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
