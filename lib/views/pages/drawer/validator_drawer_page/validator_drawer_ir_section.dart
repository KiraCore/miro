import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_text_value_widget.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_urls_value_widget.dart';

class ValidatorDrawerIrSection extends StatelessWidget {
  final bool loadingBool;
  final IRModel? irModel;

  const ValidatorDrawerIrSection({
    required this.loadingBool,
    required this.irModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).ir,
          style: textTheme.bodyText1!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 14),
        IRRecordTextValueWidget(
          loadingBool: loadingBool,
          label: S.of(context).irDescription,
          value: irModel?.descriptionIRRecordModel.value,
        ),
        const SizedBox(height: 15),
        IRRecordUrlsValueWidget(
          loadingBool: loadingBool,
          label: S.of(context).irSocialMedia,
          urls: irModel?.socialMediaIRRecordModel.value?.split(',').toList() ?? <String>[],
        ),
        const SizedBox(height: 15),
        ...?irModel?.otherIRRecordModelList.map((IRRecordModel irRecordModel) {
          return Column(
            children: <Widget>[
              if (irRecordModel.key != S.of(context).validatorsTableMoniker)
                IRRecordTextValueWidget(
                  loadingBool: loadingBool,
                  label: irRecordModel.key,
                  value: irRecordModel.value,
                ),
              if (irRecordModel.key != S.of(context).validatorsTableMoniker) const SizedBox(height: 15),
            ],
          );
        }).toList(),
      ],
    );
  }
}
