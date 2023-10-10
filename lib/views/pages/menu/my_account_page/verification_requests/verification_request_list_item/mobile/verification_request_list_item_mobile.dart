import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class VerificationRequestListItemMobile extends StatelessWidget {
  final VoidCallback onShowDrawerPressed;
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const VerificationRequestListItemMobile({
    required this.onShowDrawerPressed,
    required this.irInboundVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    IRUserProfileModel requesterIrUserProfileModel = irInboundVerificationRequestModel.requesterIrUserProfileModel;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          AccountTile(
            size: 40,
            avatarUrl: requesterIrUserProfileModel.avatarUrl,
            username: requesterIrUserProfileModel.username,
            walletAddress: requesterIrUserProfileModel.walletAddress,
            usernameTextStyle: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
            addressTextStyle: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
          ),
          const SizedBox(height: 12),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).irVerificationRequestsCreationDate,
                  child: Text(
                    DateFormat('d MMM y, HH:mm').format(irInboundVerificationRequestModel.dateTime.toLocal()),
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).irVerificationRequestsTip,
                  child: Text(
                    irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
                    style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PrefixedWidget(
            prefix: S.of(context).irVerificationRequestsRecords,
            child: Text(
              irInboundVerificationRequestModel.records.isNotEmpty ? irInboundVerificationRequestModel.records.keys.join(', ') : '---',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
            ),
          ),
          const SizedBox(height: 12),
          KiraOutlinedButton(
            height: 40,
            title: S.of(context).showDetails,
            onPressed: onShowDrawerPressed,
          ),
        ],
      ),
    );
  }
}
