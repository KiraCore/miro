import 'package:flutter/material.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_list_title/verification_requests_list_title_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_list_title/verification_requests_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class VerificationRequestsListTitle extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const VerificationRequestsListTitle({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: VerificationRequestsListTitleDesktop(searchBarTextEditingController: searchBarTextEditingController),
      mediumScreen: VerificationRequestsListTitleMobile(searchBarTextEditingController: searchBarTextEditingController),
    );
  }
}
