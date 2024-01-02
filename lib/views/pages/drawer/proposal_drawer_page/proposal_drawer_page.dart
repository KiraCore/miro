import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_view/json_view.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
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
    TextStyle textStyle = textTheme.bodyText2!.copyWith(color: DesignColors.white2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: widget.proposalModel.title,
        ),
        const SizedBox(height: 28),
        PrefixedWidget(
          prefix: S.of(context).proposalsDescription,
          child: Text(
            widget.proposalModel.description,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).proposalsTransactionHash,
          child: Text(
            widget.proposalModel.transactionHash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).proposalsProposer,
          child: Text(
            widget.proposalModel.proposer,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        Row(
          children: <Widget>[
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsAttendance,
                child: Text(
                  '${widget.proposalModel.votersCount} / ${widget.proposalModel.votesCount}',
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
        const Divider(color: DesignColors.grey2),
        Row(
          children: <Widget>[
            Expanded(
              child: PrefixedWidget(
                prefix: S.of(context).proposalsVotingStartTime,
                child: Text(
                  DateFormat('d MMM y, HH:mm').format(widget.proposalModel.submitTime),
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
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).proposalsEnactedTime,
          child: Text(
            DateFormat('d MMM y, HH:mm').format(widget.proposalModel.enactmentEndTime),
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).proposalsMetadata,
          child: Text(
            widget.proposalModel.metaData,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        Row(
          children: <Widget>[
            Expanded(
              child: PrefixedWidget(
                prefix: 'More details',
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
            CopyButton(
              notificationText: S.of(context).toastSuccessfullyCopied,
              value: widget.proposalModel.proposalTypeContentModel.getProposalContentValues().toString(),
            )
          ],
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
