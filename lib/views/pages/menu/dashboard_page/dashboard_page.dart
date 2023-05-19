import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/menu/dashboard/a_dashboard_state.dart';
import 'package:miro/blocs/pages/menu/dashboard/dashboard_cubit.dart';
import 'package:miro/blocs/pages/menu/dashboard/states/dashboard_error_state.dart';
import 'package:miro/blocs/pages/menu/dashboard/states/dashboard_loading_state.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_blocks_section.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_header_section.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_proposals_section.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_validators_section.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  final DashboardCubit _dashboardCubit = DashboardCubit();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    _dashboardCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<DashboardCubit, ADashboardState>(
      bloc: _dashboardCubit,
      builder: (BuildContext context, ADashboardState dashboardState) {
        bool loading = dashboardState is DashboardLoadingState;
        return CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: ResponsiveWidget.isLargeScreen(context) ? AppSizes.defaultDesktopPageMargin : AppSizes.defaultMobilePageMargin,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (dashboardState is DashboardErrorState) ...<Widget>[
                      ToastContainer(
                        width: double.infinity,
                        title: Text(
                          S.of(context).toastCannotLoadDashboard,
                          style: textTheme.bodyText2!,
                        ),
                        toastType: ToastType.error,
                      ),
                      const SizedBox(height: 32),
                    ],
                    DashboardHeaderSection(
                      loading: loading,
                      dashboardModel: dashboardState.dashboardModel,
                    ),
                    DashboardValidatorsSection(
                      loading: loading,
                      validatorsStatusModel: dashboardState.dashboardModel?.validatorsStatusModel,
                    ),
                    ColumnRowSwapper(
                      expandOnRow: true,
                      children: <Widget>[
                        DashboardBlocksSection(
                          loading: loading,
                          blocksModel: dashboardState.dashboardModel?.blocksModel,
                        ),
                        const ColumnRowSpacer(size: 32),
                        DashboardProposalsSection(
                          loading: loading,
                          proposalsModel: dashboardState.dashboardModel?.proposalsModel,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
