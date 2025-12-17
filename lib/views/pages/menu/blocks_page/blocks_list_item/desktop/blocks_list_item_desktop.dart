import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/shared/utils/extensions/date_time_extension.dart';
import 'package:miro/views/pages/menu/blocks_page/block_details_page.dart';
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
    return InkWrapper(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => BlockDetailsPage(
              blockModel: blockModel,
            ),
          )),
      child: BlocksListItemDesktopLayout(
        height: height,
        heightWidget: Text(
          blockModel.header.height.toString(),
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
              ? blockModel.header.time.toShortAge(context)
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
