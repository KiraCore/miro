import 'package:flutter/material.dart';
import 'package:miro/shared/models/dashboard/blocks_model.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';

class DashboardBlocsSection extends StatelessWidget {
  final bool loading;
  final BlocksModel? blocksModel;

  const DashboardBlocsSection({
    required this.loading,
    this.blocksModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardGrid(
      title: 'Blocks',
      columnsCount: 2,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: blocksModel?.currentHeight.toString(),
          subtitle: 'Current height',
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.sinceGenesis.toString(),
          subtitle: 'Since genesis',
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.pendingTransactions.toString(),
          subtitle: 'Pending transactions',
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.currentTransactions.toString(),
          subtitle: 'Current transactions',
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.latestBlocTimeString,
          subtitle: 'Latest time',
          loading: loading,
        ),
        DashboardGridTile(
          title: blocksModel?.averageBlocTimeString,
          subtitle: 'Average time',
          loading: loading,
        ),
      ],
    );
  }
}
