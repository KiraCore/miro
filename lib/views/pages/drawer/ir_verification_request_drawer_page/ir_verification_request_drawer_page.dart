import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/account_tile_copy_wrapper.dart';
import 'package:miro/views/widgets/generic/expandable_text.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRVerificationRequestDrawerPage extends StatefulWidget {
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;
  final AListBloc<IRInboundVerificationRequestModel> listBloc;

  const IRVerificationRequestDrawerPage({
    required this.irInboundVerificationRequestModel,
    required this.listBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRVerificationRequestDrawerPage();
}

class _IRVerificationRequestDrawerPage extends State<IRVerificationRequestDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    IRUserProfileModel requesterIrUserProfileModel = widget.irInboundVerificationRequestModel.requesterIrUserProfileModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: widget.irInboundVerificationRequestModel.records.length > 1
              ? S.of(context).irVerificationRequestsVerifyRecords
              : S.of(context).irVerificationRequestsVerifyRecord,
        ),
        const SizedBox(height: 24),
        AccountTileCopyWrapper.fromIRUserProfileModel(requesterIrUserProfileModel),
        const SizedBox(height: 8),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix: S.of(context).irVerificationRequestsCreationDate,
          child: Text(
            DateFormat('d MMM y, HH:mm').format(widget.irInboundVerificationRequestModel.dateTime.toLocal()),
            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
          ),
        ),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix: S.of(context).irVerificationRequestsTip,
          child: Text(
            widget.irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
              child: KiraOutlinedButton(
                height: 40,
                onPressed: _pressApproveButton,
                title: S.of(context).irVerificationRequestsApprove,
                textColor: DesignColors.greenStatus1,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: KiraOutlinedButton(
                height: 40,
                onPressed: _pressRejectButton,
                title: S.of(context).irVerificationRequestsReject,
                textColor: DesignColors.redStatus1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix:
              '${widget.irInboundVerificationRequestModel.records.length > 1 ? S.of(context).irVerificationRequestsRecordsToVerify : S.of(context).irVerificationRequestsRecordToVerify}:',
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              if (widget.irInboundVerificationRequestModel.records.isEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Text('---', style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2)),
              ],
              for (String key in widget.irInboundVerificationRequestModel.records.keys)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: DesignColors.grey2, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: DesignColors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: <Widget>[
                      PrefixedWidget(
                        prefix: S.of(context).irTxHintKey,
                        child: ExpandableText(
                          initialTextLength: const ResponsiveValue<int>(
                            largeScreen: 500,
                            mediumScreen: 300,
                            smallScreen: 150,
                          ).get(context),
                          textLengthSeeMore: 500,
                          text: Text(
                            key,
                            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).irTxHintValue,
                        child: ExpandableText(
                          initialTextLength: const ResponsiveValue<int>(
                            largeScreen: 500,
                            mediumScreen: 300,
                            smallScreen: 150,
                          ).get(context),
                          textLengthSeeMore: 500,
                          text: Text(
                            widget.irInboundVerificationRequestModel.records[key] ?? '---',
                            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }

  Future<void> _pressApproveButton() async {
    await _openTransactionPage(approvalStatusBool: true);
    widget.listBloc.add(const ListReloadEvent(forceRequestBool: true));
    Navigator.of(context).pop();
  }

  Future<void> _pressRejectButton() async {
    await _openTransactionPage(approvalStatusBool: false);
    widget.listBloc.add(const ListReloadEvent(forceRequestBool: true));
    Navigator.of(context).pop();
  }

  Future<void> _openTransactionPage({required bool approvalStatusBool}) async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxHandleVerificationRequestRoute(
          approvalStatusBool: approvalStatusBool,
          irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
        ),
      ],
    ));
  }
}
