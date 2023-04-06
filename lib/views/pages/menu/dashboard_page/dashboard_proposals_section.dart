import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/dashboard/proposals_model.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';

class DashboardProposalsSection extends StatelessWidget {
  final bool loading;
  final ProposalsModel? proposalsModel;

  const DashboardProposalsSection({
    required this.loading,
    this.proposalsModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardGrid(
      title: S.of(context).proposals,
      columnsCount: 2,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: proposalsModel?.active.toString(),
          titleSuffix: proposalsModel?.total.toString() ?? '---',
          subtitle: S.of(context).proposalsActive,
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.enacting.toString(),
          subtitle: S.of(context).proposalsEnacting,
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.finished.toString(),
          subtitle: S.of(context).proposalsFinished,
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.successful.toString(),
          subtitle: S.of(context).proposalsSuccessful,
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.proposers.toString(),
          subtitle: S.of(context).proposalsProposers,
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.voters.toString(),
          subtitle: S.of(context).proposalsVoters,
          loading: loading,
        ),
      ],
    );
  }
}
