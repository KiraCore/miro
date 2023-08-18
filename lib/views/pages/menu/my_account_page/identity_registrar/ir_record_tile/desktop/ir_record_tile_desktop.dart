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
  final bool loadingBool;
  final Widget valueWidget;
  final VoidCallback onAddPressed;
  final VoidCallback onEditPressed;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTileDesktop({
    required this.loadingBool,
    required this.valueWidget,
    required this.onAddPressed,
    required this.onEditPressed,
    required this.identityRegistrarCubit,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool recordExistsBool = irRecordModel?.value?.isNotEmpty == true;

    return IRRecordTileDesktopLayout(
      recordWidget: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: valueWidget,
      ),
      statusWidget: IRRecordStatusChip(
        loadingBool: loadingBool,
        irRecordStatus: irRecordModel?.irRecordStatus,
      ),
      buttonWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (loadingBool == false && recordExistsBool) ...<Widget>[
            IconButton(
              icon: const Icon(AppIcons.pencil, color: DesignColors.grey1, size: 20),
              tooltip: S.of(context).irRecordEdit,
              onPressed: onEditPressed,
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
