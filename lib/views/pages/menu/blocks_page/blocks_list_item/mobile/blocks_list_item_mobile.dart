import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/blocks_drawer_page/blocks_drawer_page.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class BlocksListItemMobile extends StatelessWidget {
  final BlockModel blockModel;

  const BlocksListItemMobile({
    required this.blockModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String convertToAgo(DateTime input) {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 1) {
        return '${diff.inDays} days ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hours ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minutes ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} seconds ago';
      } else {
        return 'just now';
      }
    }

    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle textStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: DesignColors.accent,
                    size: 17,
                  ),
                  tooltip: '',
                  onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(BlocksDrawerPage(
                    blockModel: blockModel,
                  )),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PrefixedWidget(
                          prefix: S.of(context).blocksHeight,
                          child: Text(
                            blockModel.header.height,
                            style: textStyle,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: PrefixedWidget(
                          prefix: S.of(context).blocksTxCount,
                          child: Text(
                            blockModel.numTxs,
                            style: textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: PrefixedWidget(
                          prefix: S.of(context).blocksDateTime,
                          child: Text(
                            convertToAgo(blockModel.header.time),
                            style: textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: PrefixedWidget(
                          prefix: S.of(context).blocksProposer,
                          child: Row(
                            children: <Widget>[
                              KiraIdentityAvatar(
                                address: blockModel.header.proposerAddress,
                                size: 32,
                              ),
                              Expanded(
                                child: Text(
                                  '${blockModel.header.proposerAddress.substring(0, 5)}...${blockModel.header.proposerAddress.substring(
                                    blockModel.header.proposerAddress.length - 5,
                                    blockModel.header.proposerAddress.length,
                                  )}',
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: DesignColors.white2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: PrefixedWidget(
                          prefix: S.of(context).blocksHash,
                          child: Text(
                            blockModel.blockId.hash,
                            style: textStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
