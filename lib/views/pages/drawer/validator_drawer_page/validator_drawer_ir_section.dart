import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_text_value_widget.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_urls_value_widget.dart';

class ValidatorDrawerIrSection extends StatelessWidget {
  final ValidatorModel validatorModel;

  const ValidatorDrawerIrSection({
    required this.validatorModel,
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
          style: textTheme.bodyLarge!.copyWith(color: DesignColors.white1),
        ),
        const SizedBox(height: 15),
        IRRecordTextValueWidget(
          loadingBool: false,
          label: S.of(context).irContact,
          value: validatorModel.description,
        ),
        const SizedBox(height: 15),
        IRRecordTextValueWidget(
          loadingBool: false,
          label: S.of(context).irDescription,
          value: validatorModel.contact,
        ),
        const SizedBox(height: 15),
        if (validatorModel.social != null)
          IRRecordUrlsValueWidget(
            loadingBool: false,
            label: S.of(context).irSocialMedia,
            urls: <String>[validatorModel.social!],
          ),
        const SizedBox(height: 10),
        if (validatorModel.website != null)
          IRRecordUrlsValueWidget(
            loadingBool: false,
            label: S.of(context).irWebsite,
            urls: <String>[validatorModel.website!],
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
