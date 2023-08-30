import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/views/pages/drawer/ir_record_drawer_page/ir_record_verifications_list_tile.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class IRRecordVerificationsList extends StatelessWidget {
  final List<IRVerificationModel> irVerificationModels;

  const IRRecordVerificationsList({
    required this.irVerificationModels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IRVerificationModel> confirmedIrRecordVerificationsList = irVerificationModels
        .where((IRVerificationModel irVerificationModel) => irVerificationModel.irVerificationRequestStatus == IRVerificationRequestStatus.confirmed)
        .toList();

    List<IRVerificationModel> pendingIrRecordVerificationsList = irVerificationModels
        .where((IRVerificationModel irVerificationModel) => irVerificationModel.irVerificationRequestStatus == IRVerificationRequestStatus.pending)
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
                return IRRecordVerificationsListTile(irVerificationModel: confirmedIrRecordVerificationsList[index]);
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
                return IRRecordVerificationsListTile(irVerificationModel: pendingIrRecordVerificationsList[index]);
              },
            ),
          ),
        ],
      ],
    );
  }
}
