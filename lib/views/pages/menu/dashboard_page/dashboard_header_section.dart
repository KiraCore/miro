import 'package:flutter/widgets.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/shared/models/dashboard/consensus_state_type.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/kira/kira_card.dart';

class DashboardHeaderSection extends StatelessWidget {
  final bool loading;
  final DashboardModel? dashboardModel;

  const DashboardHeaderSection({
    required this.loading,
    this.dashboardModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<ConsensusStateType, String> consensusStateTypeMessages = <ConsensusStateType, String>{
      ConsensusStateType.healthy: 'Healthy',
      ConsensusStateType.unhealthy: 'Unhealthy',
    };

    return ColumnRowSwapper(
      expandOnRow: true,
      children: <Widget>[
        KiraCard(
          child: DashboardGridTile.icon(
            title: dashboardModel?.currentBlockValidatorModel.moniker,
            subtitle: 'Current Block Validator',
            loading: loading,
            icon: const Icon(
              AppIcons.block,
              color: Color(0xFFF44082),
            ),
          ),
        ),
        const ColumnRowSpacer(size: 32),
        KiraCard(
          child: DashboardGridTile.icon(
            title: dashboardModel?.consensusHealthPercentage,
            subtitle: 'Consensus',
            loading: loading,
            icon: const Icon(
              AppIcons.consensus,
              color: Color(0xFFD429FF),
            ),
          ),
        ),
        const ColumnRowSpacer(size: 32),
        KiraCard(
          child: DashboardGridTile.icon(
            title: consensusStateTypeMessages[dashboardModel?.validatorsStatusModel.consensusStateType],
            subtitle: 'Consensus state',
            loading: loading,
            icon: const Icon(
              AppIcons.health,
              color: Color(0xFFF2E46C),
            ),
          ),
        ),
      ],
    );
  }
}
