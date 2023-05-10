import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';

abstract class ADashboardState extends Equatable {
  final DashboardModel? dashboardModel;

  const ADashboardState({
    this.dashboardModel,
  });

  @override
  List<Object?> get props => <Object?>[dashboardModel];
}
