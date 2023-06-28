import 'package:flutter/cupertino.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_title/validator_list_title_desktop.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_title/validator_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ValidatorListTitle extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const ValidatorListTitle({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: ValidatorListTitleDesktop(searchBarTextEditingController: searchBarTextEditingController),
      mediumScreen: ValidatorListTitleMobile(searchBarTextEditingController: searchBarTextEditingController),
    );
  }
}
