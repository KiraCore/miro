import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_sort_dropdown.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class VerificationRequestsListTitleMobile extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const VerificationRequestsListTitleMobile({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 15),
        ListSearchWidget<IRInboundVerificationRequestModel>(
          textEditingController: searchBarTextEditingController,
          width: double.infinity,
          hint: S.of(context).irVerificationRequestsListSearchRequests,
        ),
        const SizedBox(height: 15),
        VerificationRequestsSortDropdown(width: ResponsiveWidget.isSmallScreen(context) ? 62 : 100),
      ],
    );
  }
}
