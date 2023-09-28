import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/views/pages/drawer/ir_record_drawer_page/ir_record_verifications_list_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class IRRecordVerificationsList extends StatelessWidget {
  final List<IRRecordVerificationRequestModel> irRecordVerificationRequestModels;

  const IRRecordVerificationsList({
    required this.irRecordVerificationRequestModels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IRRecordVerificationRequestModel> confirmedIrRecordVerificationsList = irRecordVerificationRequestModels
        .where((IRRecordVerificationRequestModel e) => e.irVerificationRequestStatus == IRVerificationRequestStatus.confirmed)
        .toList();

    List<IRRecordVerificationRequestModel> pendingIrRecordVerificationsList = irRecordVerificationRequestModels
        .where((IRRecordVerificationRequestModel e) => e.irVerificationRequestStatus == IRVerificationRequestStatus.pending)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (confirmedIrRecordVerificationsList.isNotEmpty) ...<Widget>[
          PrefixedWidget(
            prefix: S.of(context).irRecordConfirmedVerifications,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: confirmedIrRecordVerificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return IRRecordVerificationsListTile(irRecordVerificationRequestModel: confirmedIrRecordVerificationsList[index]);
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
        if (pendingIrRecordVerificationsList.isNotEmpty) ...<Widget>[
          PrefixedWidget(
            prefix: S.of(context).irRecordPendingVerifications,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pendingIrRecordVerificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return IRRecordVerificationsListTile(irRecordVerificationRequestModel: pendingIrRecordVerificationsList[index]);
              },
            ),
          ),
        ],
      ],
    );
  }
}
