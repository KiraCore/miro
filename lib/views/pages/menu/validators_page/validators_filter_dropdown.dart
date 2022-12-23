import 'package:flutter/material.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_filter_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class ValidatorsFilterDropdown extends StatelessWidget {
  final double width;

  const ValidatorsFilterDropdown({
    this.width = 100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterDropdown<ValidatorModel>(
      width: width,
      title: 'Status',
      filterOptionModels: <FilterOptionModel<ValidatorModel>>[
        FilterOptionModel<ValidatorModel>(
          title: 'Active',
          filterOption: ValidatorsFilterOptions.filterByActiveValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: 'Inactive',
          filterOption: ValidatorsFilterOptions.filterByInactiveValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: 'Jailed',
          filterOption: ValidatorsFilterOptions.filterByJailedValidators,
        ),
        FilterOptionModel<ValidatorModel>(
          title: 'Paused',
          filterOption: ValidatorsFilterOptions.filterByPausedValidators,
        ),
      ],
    );
  }
}
