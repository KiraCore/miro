import 'package:flutter/cupertino.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_title/staking_list_title_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_title/staking_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class StakingListTitle extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const StakingListTitle({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: StakingListTitleDesktop(searchBarTextEditingController: searchBarTextEditingController),
      mediumScreen: StakingListTitleMobile(searchBarTextEditingController: searchBarTextEditingController),
    );
  }
}
