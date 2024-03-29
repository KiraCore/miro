import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/views/widgets/generic/account_tile_copy_wrapper.dart';
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
          const SizedBox(height: 30),
          PrefixedWidget(
            prefix: S.of(context).irRecordConfirmedVerifications,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: confirmedIrRecordVerificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountTileCopyWrapper.fromIRUserProfileModel(confirmedIrRecordVerificationsList[index].verifierIrUserProfileModel);
              },
            ),
          ),
        ],
        if (confirmedIrRecordVerificationsList.isNotEmpty && pendingIrRecordVerificationsList.isNotEmpty)
          const SizedBox(height: 15)
        else if (confirmedIrRecordVerificationsList.isEmpty && pendingIrRecordVerificationsList.isNotEmpty)
          const SizedBox(height: 30),
        if (pendingIrRecordVerificationsList.isNotEmpty) ...<Widget>[
          PrefixedWidget(
            prefix: S.of(context).irRecordPendingVerifications,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pendingIrRecordVerificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return AccountTileCopyWrapper.fromIRUserProfileModel(pendingIrRecordVerificationsList[index].verifierIrUserProfileModel);
              },
            ),
          ),
        ],
      ],
    );
  }
}
