import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/desktop/verification_request_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class VerificationRequestListItemDesktop extends StatelessWidget {
  final VoidCallback onApproveButtonPressed;
  final VoidCallback onRejectButtonPressed;
  final VoidCallback onShowDrawerPressed;
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const VerificationRequestListItemDesktop({
    required this.onApproveButtonPressed,
    required this.onRejectButtonPressed,
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
        usernameTextStyle: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
        addressTextStyle: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      dateWidget: Text(
        DateFormat('d MMM y, HH:mm').format(irInboundVerificationRequestModel.dateTime.toLocal()),
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      keysWidget: Text(
        irInboundVerificationRequestModel.records.isNotEmpty ? irInboundVerificationRequestModel.records.keys.join(', ') : '---',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      tipWidget: Text(
        irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
      ),
      actionsWidget: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              child: KiraOutlinedButton(
                height: 40,
                onPressed: onApproveButtonPressed,
                title: S.of(context).irVerificationRequestsApprove,
                textColor: DesignColors.greenStatus1,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KiraOutlinedButton(
                height: 40,
                onPressed: onRejectButtonPressed,
                title: S.of(context).irVerificationRequestsReject,
                textColor: DesignColors.redStatus1,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
