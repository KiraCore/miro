import 'package:flutter/material.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_title/undelegation_list_title_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_title/undelegation_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class UndelegationListTitle extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const UndelegationListTitle({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: UndelegationListTitleDesktop(searchBarTextEditingController: searchBarTextEditingController),
      mediumScreen: UndelegationListTitleMobile(searchBarTextEditingController: searchBarTextEditingController),
    );
  }
}
