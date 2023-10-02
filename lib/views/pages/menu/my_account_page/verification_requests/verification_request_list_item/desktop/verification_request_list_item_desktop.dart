import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/desktop/verification_request_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class VerificationRequestListItemDesktop extends StatelessWidget {
  final VoidCallback onShowDrawerPressed;
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const VerificationRequestListItemDesktop({
    required this.onShowDrawerPressed,
    required this.irInboundVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    IRUserProfileModel requesterIrUserProfileModel = irInboundVerificationRequestModel.requesterIrUserProfileModel;

    return VerificationRequestListItemDesktopLayout(
      infoButtonWidget: IconButton(
        icon: const Icon(
          Icons.info_outline,
          color: DesignColors.white2,
          size: 25,
        ),
        onPressed: onShowDrawerPressed,
      ),
      requesterAddressWidget: AccountTile(
        size: 40,
        avatarUrl: requesterIrUserProfileModel.avatarUrl,
        username: requesterIrUserProfileModel.username,
        walletAddress: requesterIrUserProfileModel.walletAddress,
        usernameTextStyle: textTheme.bodyText1!.copyWith(color: DesignColors.white1),
        addressTextStyle: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
      ),
      dateWidget: Text(
        DateFormat('d MMM y, HH:mm').format(irInboundVerificationRequestModel.dateTime.toLocal()),
        style: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
      ),
      keysWidget: Text(
        irInboundVerificationRequestModel.records.isNotEmpty ? irInboundVerificationRequestModel.records.keys.join(', ') : '---',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
      ),
      tipWidget: Text(
        irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
        style: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
      ),
    );
  }
}
