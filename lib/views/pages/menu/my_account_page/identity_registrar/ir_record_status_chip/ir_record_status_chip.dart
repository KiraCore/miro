import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_status.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_status_chip/ir_record_status_chip_model.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';

class IRRecordStatusChip extends StatelessWidget {
  final bool loadingBool;
  final IRRecordModel? irRecordModel;

  const IRRecordStatusChip({
    required this.loadingBool,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (loadingBool) {
      return const LoadingContainer(
        height: 20,
        width: 80,
        circularBorderRadius: 5,
      );
    }

    IRRecordStatusChipModel irRecordStatusChipModel = _assignStatusChipModel(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: irRecordStatusChipModel.color.withAlpha(20),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (irRecordStatusChipModel.icon != null) ...<Widget>[
            irRecordStatusChipModel.icon!,
            const SizedBox(width: 6),
          ],
          Text(
            irRecordStatusChipModel.title,
            style: textTheme.bodySmall!.copyWith(
              color: irRecordStatusChipModel.color,
            ),
          ),
        ],
      ),
    );
  }

  IRRecordStatusChipModel _assignStatusChipModel(BuildContext context) {
    switch (irRecordModel!.irRecordStatus) {
      case IRRecordStatus.verified:
        return IRRecordStatusChipModel(
          color: DesignColors.greenStatus1,
          title: S.of(context).irRecordStatusVerificationsCount(irRecordModel!.verifiersAddresses.length),
          icon: const Icon(
            AppIcons.verification,
            color: DesignColors.greenStatus1,
            size: 12,
          ),
        );
      case IRRecordStatus.pending:
        return IRRecordStatusChipModel(
          color: DesignColors.yellowStatus1,
          title: S.of(context).irRecordStatusPending,
        );
      case IRRecordStatus.notVerified:
        return IRRecordStatusChipModel(
          color: DesignColors.redStatus1,
          title: S.of(context).irRecordStatusNotVerified,
        );
    }
  }
}
