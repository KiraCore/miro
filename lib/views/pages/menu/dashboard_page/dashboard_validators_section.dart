import 'package:flutter/widgets.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';

class DashboardValidatorsSection extends StatelessWidget {
  final bool loading;
  final ValidatorsStatusModel? validatorsStatusModel;

  const DashboardValidatorsSection({
    required this.loading,
    this.validatorsStatusModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardGrid(
      title: 'Validators',
      columnsCount: 6,
      mobileColumnsCount: 2,
      tabletColumnsCount: 3,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: validatorsStatusModel?.totalValidators.toString(),
          subtitle: 'Total',
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.activeValidators.toString(),
          subtitle: 'Active',
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.inactiveValidators.toString(),
          subtitle: 'Inactive',
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.jailedValidators.toString(),
          subtitle: 'Jailed',
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.pausedValidators.toString(),
          subtitle: 'Paused',
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.waitingValidators.toString(),
          subtitle: 'Waiting',
          loading: loading,
        ),
      ],
    );
  }
}
