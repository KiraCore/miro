import 'package:flutter/widgets.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
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
      ConsensusStateType.healthy: S.of(context).consensusHealthy,
      ConsensusStateType.unhealthy: S.of(context).consensusUnhealthy,
    };

    return ColumnRowSwapper(
      expandOnRow: true,
      children: <Widget>[
        KiraCard(
          child: DashboardGridTile.icon(
            title: dashboardModel?.currentBlockValidatorModel.moniker,
            subtitle: S.of(context).consensusCurrentBlockValidator,
            loading: loading,
            icon: const Icon(
              AppIcons.block,
              color: DesignColors.pink,
            ),
          ),
        ),
        const ColumnRowSpacer(size: 32),
        KiraCard(
          child: DashboardGridTile.icon(
            title: dashboardModel?.consensusHealthPercentage,
            subtitle: S.of(context).consensus,
            loading: loading,
            icon: const Icon(
              AppIcons.consensus,
              color: DesignColors.orange,
            ),
          ),
        ),
        const ColumnRowSpacer(size: 32),
        KiraCard(
          child: DashboardGridTile.icon(
            title: consensusStateTypeMessages[dashboardModel?.validatorsStatusModel.consensusStateType],
            subtitle: S.of(context).consensusState,
            loading: loading,
            icon: const Icon(
              AppIcons.health,
              color: DesignColors.turquoise,
            ),
          ),
        ),
      ],
    );
  }
}
