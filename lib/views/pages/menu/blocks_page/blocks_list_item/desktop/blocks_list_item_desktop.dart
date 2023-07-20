import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/blocks_drawer_page/blocks_drawer_page.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/desktop/blocks_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class BlocksListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final BlockModel blockModel;

  const BlocksListItemDesktop({
    required this.blockModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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

    return BlocksListItemDesktopLayout(
      kiraToolTipWidget: IconButton(
        icon: const Icon(
          Icons.info_outline,
          color: DesignColors.accent,
          size: 17,
        ),
        onPressed: () {
          KiraScaffold.of(context).navigateEndDrawerRoute(BlocksDrawerPage(
            blockModel: blockModel,
          ));
        },
      ),
      height: height,
      heightWidget: Text(
        blockModel.header.height,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      proposerWidget: Row(
        children: <Widget>[
          KiraIdentityAvatar(
            address: blockModel.header.proposerAddress,
            size: 32,
          ),
          Text(
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
        ],
      ),
      hashWidget: CopyWrapper(
        value: blockModel.blockId.hash,
        notificationText: S.of(context).toastSuccessfullyCopied,
        child: Text(
          '${blockModel.blockId.hash.substring(0, 5)}...${blockModel.blockId.hash.substring(
            blockModel.blockId.hash.length - 5,
            blockModel.blockId.hash.length,
          )}',
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(
            color: DesignColors.white2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ageWidget: Text(
        convertToAgo(blockModel.header.time),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      txCountWidget: Text(
        blockModel.numTxs,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
    );
  }
}
