import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_status_chip/ir_record_status_chip.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop_layout.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class IRRecordTileDesktop extends StatelessWidget {
  final bool infoButtonVisibleBool;
  final bool loadingBool;
  final Widget valueWidget;
  final VoidCallback onAddPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onVerifyPressed;
  final VoidCallback onShowDrawerPressed;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTileDesktop({
    required this.infoButtonVisibleBool,
    required this.loadingBool,
    required this.valueWidget,
    required this.onAddPressed,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.onVerifyPressed,
    required this.identityRegistrarCubit,
    required this.onShowDrawerPressed,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool recordExistsBool = irRecordModel?.value?.isNotEmpty == true;

    return IRRecordTileDesktopLayout(
      infoButtonVisibleBool: infoButtonVisibleBool,
      infoButtonWidget: recordExistsBool
          ? IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: DesignColors.white2,
                size: 25,
              ),
              onPressed: onShowDrawerPressed,
            )
          : const SizedBox(),
      recordWidget: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: valueWidget,
      ),
      statusWidget: (irRecordModel?.value != null && (irRecordModel!.value!.isNotEmpty))
          ? IRRecordStatusChip(
              loadingBool: loadingBool,
              irRecordModel: irRecordModel,
            )
          : const SizedBox(),
      buttonWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (loadingBool == false && recordExistsBool) ...<Widget>[
            IconButton(
              icon: const Icon(AppIcons.verification, color: DesignColors.grey1, size: 20),
              tooltip: S.of(context).irRecordVerify,
              onPressed: onVerifyPressed,
            ),
            IconButton(
              icon: const Icon(AppIcons.pencil, color: DesignColors.grey1, size: 20),
              tooltip: S.of(context).irRecordEdit,
              onPressed: onEditPressed,
            ),
            IconButton(
              icon: const Icon(AppIcons.delete, color: DesignColors.grey1, size: 20),
              tooltip: S.of(context).irRecordDelete,
              onPressed: onDeletePressed,
            ),
          ] else if (loadingBool == false)
            KiraOutlinedButton(
              width: 76,
              height: 40,
              title: S.of(context).irRecordAdd,
              onPressed: onAddPressed,
            ),
        ],
      ),
    );
  }
}
