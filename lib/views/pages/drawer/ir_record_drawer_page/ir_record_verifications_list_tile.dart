import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class IRRecordVerificationsListTile extends StatelessWidget {
  final IRVerificationModel irVerificationModel;

  const IRRecordVerificationsListTile({
    required this.irVerificationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IRModel irModel = irVerificationModel.verifierIrModel;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: AccountTile(
              walletAddress: irModel.walletAddress,
              username: irModel.usernameIRRecordModel.value,
              avatarUrl: irModel.avatarIRRecordModel.value,
            ),
          ),
          const SizedBox(width: 8),
          CopyButton(
            value: irModel.walletAddress.bech32Address,
            notificationText: S.of(context).toastPublicAddressCopied,
            size: 20,
          ),
          const SizedBox(width: 6),
          KiraToolTip(
            message: irModel.walletAddress.bech32Address,
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
