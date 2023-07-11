import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_filter_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class ValidatorsFilterDropdown extends StatelessWidget {
  final double width;
  final MainAxisAlignment mainAxisAlignment;

  const ValidatorsFilterDropdown({
    this.width = 100,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterDropdown<ValidatorModel>(
      width: width,
      title: S.of(context).validatorsTableStatus,
      filterOptionModels: <FilterOptionModel<ValidatorModel>>[
        FilterOptionModel<ValidatorModel>(
          title: S.of(context).validatorsActive,
          filterOption: ValidatorsFilterOptions.filterByActiveValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: S.of(context).validatorsInactive,
          filterOption: ValidatorsFilterOptions.filterByInactiveValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: S.of(context).validatorsJailed,
          filterOption: ValidatorsFilterOptions.filterByJailedValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: S.of(context).validatorsPaused,
          filterOption: ValidatorsFilterOptions.filterByPausedValidators,
        ),
      ],
    );
  }
}
