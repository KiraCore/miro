import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';
import 'package:miro/shared/router/router.gr.dart';
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
      title: S.of(context).validators,
      onTap: () => AutoRouter.of(context).push(const ValidatorsRoute()),
      columnsCount: 6,
      mobileColumnsCount: 2,
      tabletColumnsCount: 3,
      items: <DashboardGridTile>[
        DashboardGridTile(
          title: validatorsStatusModel?.totalValidators.toString(),
          subtitle: S.of(context).validatorsTotal,
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.activeValidators.toString(),
          subtitle: S.of(context).validatorsActive,
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.inactiveValidators.toString(),
          subtitle: S.of(context).validatorsInactive,
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.jailedValidators.toString(),
          subtitle: S.of(context).validatorsJailed,
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.pausedValidators.toString(),
          subtitle: S.of(context).validatorsPaused,
          loading: loading,
        ),
        DashboardGridTile(
          title: validatorsStatusModel?.waitingValidators.toString(),
          subtitle: S.of(context).validatorsWaiting,
          loading: loading,
        ),
      ],
    );
  }
}
