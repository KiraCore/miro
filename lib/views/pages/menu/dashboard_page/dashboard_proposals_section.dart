import 'package:flutter/material.dart';
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
      title: 'Proposals',
      columnsCount: 2,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: proposalsModel?.active.toString(),
          titleSuffix: proposalsModel?.total.toString() ?? '---',
          subtitle: 'Active',
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.enacting.toString(),
          subtitle: 'Enacting',
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.finished.toString(),
          subtitle: 'Finished',
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.successful.toString(),
          subtitle: 'Successfull',
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.proposers.toString(),
          subtitle: 'Proposers',
          loading: loading,
        ),
        DashboardGridTile(
          title: proposalsModel?.voters.toString(),
          subtitle: 'Voters',
          loading: loading,
        ),
      ],
    );
  }
}
