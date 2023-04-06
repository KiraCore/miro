import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';

class DashboardBlocksSection extends StatelessWidget {
  final bool loading;
  final BlocksModel? blocksModel;

  const DashboardBlocksSection({
    required this.loading,
    this.blocksModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardGrid(
      title: S.of(context).blocks,
      columnsCount: 2,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: blocksModel?.currentHeight.toString(),
          subtitle: S.of(context).blocksCurrentHeight,
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.sinceGenesis.toString(),
          subtitle: S.of(context).blocksSinceGenesis,
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.pendingTransactions.toString(),
          subtitle: S.of(context).blocksPendingTransactions,
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.currentTransactions.toString(),
          subtitle: S.of(context).blocksCurrentTransactions,
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.getLatestBlocTimeString(context),
          subtitle: S.of(context).blocksLatestTime,
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.getAverageBlocTimeString(context),
          subtitle: S.of(context).blocksAverageTime,
          loading: loading,
        ),
      ],
    );
  }
}
