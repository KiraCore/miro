import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_view/json_view.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_status_chip/proposal_status_chip.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class ProposalDrawerPage extends StatefulWidget {
  final ProposalModel proposalModel;

  const ProposalDrawerPage({
    required this.proposalModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposalDrawerPage();
}

class _ProposalDrawerPage extends State<ProposalDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle textStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: widget.proposalModel.title,
        ),
        const SizedBox(height: 8),
        ProposalStatusChip(proposalStatus: widget.proposalModel.proposalStatus ?? ProposalStatus.unknown),
        const SizedBox(height: 28),
        PrefixedWidget(
          prefix: S.of(context).proposalsProposer,
          child: AccountTile(
            walletAddress: widget.proposalModel.proposer.walletAddress,
            addressVisibleBool: false,
            avatarUrl: widget.proposalModel.proposer.logo,
            username: widget.proposalModel.proposer.moniker,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 8),
        PrefixedWidget(
          prefix: S.of(context).proposalsDescription,
          child: Text(
            widget.proposalModel.description,
            style: textStyle,
          ),
        ),
        const SizedBox(height: 14),
        PrefixedWidget(
          prefix: S.of(context).proposalsTransactionHash,
          child: Text(
            widget.proposalModel.transactionHash,
            style: textStyle,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsAttendance,
                child: Text(
                  widget.proposalModel.attendance,
                  style: textStyle,
                ),
              ),
            ),
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsQuorum,
                child: Text(
                  widget.proposalModel.quorum,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsVotingStartTime,
                child: Text(
                  DateFormat('d MMM y, HH:mm').format(widget.proposalModel.votingStartTime),
                  style: textStyle,
                ),
              ),
            ),
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsVotingEndTime,
                child: Text(
                  DateFormat('d MMM y, HH:mm').format(widget.proposalModel.votingEndTime),
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        PrefixedWidget(
          prefix: S.of(context).proposalsEnactedTime,
          child: Text(
            DateFormat('d MMM y, HH:mm').format(widget.proposalModel.votingStartTime),
            style: textStyle,
          ),
        ),
        const SizedBox(height: 14),
        PrefixedWidget(
          prefix: S.of(context).proposalsMetadata,
          child: Text(
            widget.proposalModel.metaData,
            style: textStyle,
          ),
        ),
        const SizedBox(height: 14),
        if (widget.proposalModel.proposalTypeContentModel.getProposalContentValues().isNotEmpty)
          PrefixedWidget(
            prefix: S.of(context).proposalsDrawerMoreDetails,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: DesignColors.black,
                      border: Border.all(color: DesignColors.greyOutline),
                    ),
                    child: JsonView(
                      json: widget.proposalModel.proposalTypeContentModel.getProposalContentValues(),
                      shrinkWrap: const ResponsiveValue<bool>(
                        largeScreen: true,
                        mediumScreen: true,
                        smallScreen: true,
                      ).get(context),
                      styleScheme: const JsonStyleScheme(
                        openAtStart: false,
                      ),
                      colorScheme: const JsonColorScheme(stringColor: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CopyButton(
                  notificationText: S.of(context).toastSuccessfullyCopied,
                  value: widget.proposalModel.proposalTypeContentModel.getProposalContentValues().toString(),
                  size: 20,
                )
              ],
            ),
          ),
        const SizedBox(height: 28),
      ],
    );
  }
}
