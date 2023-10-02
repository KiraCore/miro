import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class VerificationRequestsListTitleDesktop extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const VerificationRequestsListTitleDesktop({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(height: 15),
            VerificationRequestsSortDropdown(),
          ],
        ),
        const Spacer(),
        ListSearchWidget<IRInboundVerificationRequestModel>(
          textEditingController: searchBarTextEditingController,
          hint: S.of(context).irVerificationRequestsListSearchRequests,
        ),
      ],
    );
  }
}
