import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/validators_page/validators_filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class ValidatorListTitleDesktop extends StatelessWidget {
  const ValidatorListTitleDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'List of Validators',
            style: textTheme.headline2!.copyWith(
              color: DesignColors.white_100,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  ValidatorsFilterDropdown(),
                  SizedBox(width: 32),
                  Expanded(
                    child: ListSearchWidget<ValidatorModel>(hint: 'Search validators'),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
