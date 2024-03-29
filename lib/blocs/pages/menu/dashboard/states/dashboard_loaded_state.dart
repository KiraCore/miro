import 'package:miro/blocs/pages/menu/dashboard/a_dashboard_state.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';

class DashboardLoadedState extends ADashboardState {
  const DashboardLoadedState({
    required DashboardModel dashboardModel,
  }) : super(dashboardModel: dashboardModel);
}
