import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegations_sort_options.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class UndelegationsSortDropdown extends StatelessWidget {
  final double width;

  const UndelegationsSortDropdown({
    this.width = 100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SortDropdown<UndelegationModel>(
      width: width,
      sortOptionModels: <SortOptionModel<UndelegationModel>>[
        SortOptionModel<UndelegationModel>(
          title: S.of(context).txListDate,
          sortOption: UndelegationsSortOptions.sortByDate,
        ),
      ],
    );
  }
}
