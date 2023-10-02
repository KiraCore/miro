import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/verification_requests_list_controller/verification_requests_sort_options.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class VerificationRequestsSortDropdown extends StatelessWidget {
  final double width;

  const VerificationRequestsSortDropdown({
    this.width = 100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SortDropdown<IRInboundVerificationRequestModel>(
      width: width,
      sortOptionModels: <SortOptionModel<IRInboundVerificationRequestModel>>[
        SortOptionModel<IRInboundVerificationRequestModel>(
          title: S.of(context).irVerificationRequestsCreationDate,
          sortOption: VerificationRequestsSortOptions.sortByDate,
        ),
        SortOptionModel<IRInboundVerificationRequestModel>(
          title: S.of(context).irVerificationRequestsTip,
          sortOption: VerificationRequestsSortOptions.sortByTip,
        ),
      ],
    );
  }
}
