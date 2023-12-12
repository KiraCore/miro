import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegations_sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class UndelegationListTitleDesktop extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const UndelegationListTitleDesktop({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            UndelegationsSortDropdown(),
          ],
        ),
        const SizedBox(width: 32),
        Align(
          alignment: Alignment.bottomRight,
          child: ListSearchWidget<UndelegationModel>(
            textEditingController: searchBarTextEditingController,
            hint: S.of(context).unstakedHintSearch,
          ),
        ),
      ],
    );
  }
}
