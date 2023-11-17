import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class AccountTileCopyWrapper extends StatelessWidget {
  final WalletAddress walletAddress;
  final String? moniker;
  final String? logo;

  const AccountTileCopyWrapper({
    required this.moniker,
    required this.logo,
    required this.walletAddress,
    Key? key,
  }) : super(key: key);

  factory AccountTileCopyWrapper.fromValidatorSimplifiedModel(ValidatorSimplifiedModel validatorSimplifiedModel) {
    return AccountTileCopyWrapper(
      moniker: validatorSimplifiedModel.moniker,
      logo: validatorSimplifiedModel.logo,
      walletAddress: validatorSimplifiedModel.walletAddress,
    );
  }

  factory AccountTileCopyWrapper.fromIRUserProfileModel(IRUserProfileModel irUserProfileModel) {
    return AccountTileCopyWrapper(
      moniker: irUserProfileModel.username,
      logo: irUserProfileModel.avatarUrl,
      walletAddress: irUserProfileModel.walletAddress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: AccountTile(
              walletAddress: walletAddress,
              username: moniker,
              avatarUrl: logo,
            ),
          ),
          const SizedBox(width: 8),
          CopyButton(
            value: walletAddress.bech32Address,
            notificationText: S.of(context).toastPublicAddressCopied,
            size: 20,
          ),
          const SizedBox(width: 6),
          KiraToolTip(
            message: walletAddress.bech32Address,
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
