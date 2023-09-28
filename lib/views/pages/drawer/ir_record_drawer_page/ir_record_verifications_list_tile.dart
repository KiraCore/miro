import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class IRRecordVerificationsListTile extends StatelessWidget {
  final IRRecordVerificationRequestModel irRecordVerificationRequestModel;

  const IRRecordVerificationsListTile({
    required this.irRecordVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IRUserProfileModel irUserProfileModel = irRecordVerificationRequestModel.verifierIrUserProfileModel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: AccountTile(
              walletAddress: irUserProfileModel.walletAddress,
              username: irUserProfileModel.username,
              avatarUrl: irUserProfileModel.avatarUrl,
            ),
          ),
          const SizedBox(width: 8),
          CopyButton(
            value: irUserProfileModel.walletAddress.bech32Address,
            notificationText: S.of(context).toastPublicAddressCopied,
            size: 20,
          ),
          const SizedBox(width: 6),
          KiraToolTip(
            message: irUserProfileModel.walletAddress.bech32Address,
            child: const Icon(
              Icons.info_outline,
              color: DesignColors.white2,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
