import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_status_chip/ir_record_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class IRRecordTileMobile extends StatelessWidget {
  final bool loadingBool;
  final Widget valueWidget;
  final VoidCallback onAddPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTileMobile({
    required this.loadingBool,
    required this.valueWidget,
    required this.onAddPressed,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.identityRegistrarCubit,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool recordExistsBool = irRecordModel?.value?.isNotEmpty == true;

    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: valueWidget,
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                S.of(context).irRecordStatus,
                style: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
              ),
              const SizedBox(width: 8),
              IRRecordStatusChip(
                loadingBool: loadingBool,
                irRecordStatus: irRecordModel?.irRecordStatus,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (loadingBool == false && recordExistsBool) ...<Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    height: 40,
                    title: S.of(context).irRecordEdit,
                    onPressed: onEditPressed,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: KiraOutlinedButton(
                    height: 40,
                    title: S.of(context).irRecordDelete,
                    onPressed: onDeletePressed,
                  ),
                ),
              ] else if (loadingBool == false)
                Expanded(
                  child: KiraOutlinedButton(
                    height: 40,
                    title: S.of(context).irRecordAdd,
                    onPressed: onAddPressed,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
