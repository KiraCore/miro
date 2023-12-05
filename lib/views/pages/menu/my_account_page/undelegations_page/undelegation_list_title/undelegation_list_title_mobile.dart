import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegations_sort_dropdown.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class UndelegationListTitleMobile extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const UndelegationListTitleMobile({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: ListSearchWidget<UndelegationModel>(
            textEditingController: searchBarTextEditingController,
            hint: S.of(context).undelegationsHintSearch,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            UndelegationsSortDropdown(width: ResponsiveWidget.isSmallScreen(context) ? 62 : 100),
          ],
        ),
      ],
    );
  }
}
