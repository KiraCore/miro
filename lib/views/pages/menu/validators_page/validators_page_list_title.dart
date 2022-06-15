import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_filter_options.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/filter_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/widgets/kira/kira_list/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/search_option_widget.dart';

class ValidatorsPageListTitle extends StatelessWidget {
  const ValidatorsPageListTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Text(
            'List of validators',
            style: TextStyle(
              fontSize: 26,
              color: DesignColors.white_100,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FilterDropdown<ValidatorModel, ValidatorsListBloc>(
                filterOptions: <FilterModel<ValidatorModel>>[
                  FilterModel<ValidatorModel>(
                    name: 'Active',
                    filterOption: ValidatorsFilterOptions.filterByActiveValidators,
                  ),
                  FilterModel<ValidatorModel>(
                    name: 'Inactive',
                    filterOption: ValidatorsFilterOptions.filterByInactiveValidators,
                  ),
                  FilterModel<ValidatorModel>(
                    name: 'Jailed',
                    filterOption: ValidatorsFilterOptions.filterByJailedValidators,
                  ),
                  FilterModel<ValidatorModel>(
                    name: 'Paused',
                    filterOption: ValidatorsFilterOptions.filterByPausedValidators,
                  ),
                  FilterModel<ValidatorModel>(
                    name: 'Waiting',
                    filterOption: ValidatorsFilterOptions.filterByWaitingValidators,
                  ),
                ],
              ),
              const SearchOptionWidget<ValidatorModel, ValidatorsListBloc>(),
            ],
          ),
        ),
      ],
    );
  }
}
