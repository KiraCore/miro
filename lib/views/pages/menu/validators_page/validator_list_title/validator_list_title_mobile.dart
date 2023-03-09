import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/validators_page/validators_filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class ValidatorListTitleMobile extends StatelessWidget {
  const ValidatorListTitleMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'List of Validators',
          style: textTheme.headline3!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 12),
        const ListSearchWidget<ValidatorModel>(hint: 'Search validators'),
        const SizedBox(height: 12),
        const ValidatorsFilterDropdown(),
      ],
    );
  }
}
