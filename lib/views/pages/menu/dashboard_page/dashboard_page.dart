import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/views/layout/footer/footer.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';
import 'package:miro/views/widgets/generic/filled_scroll_view.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledScrollView(
      child: Padding(
        padding: ResponsiveWidget.isLargeScreen(context) ? AppSizes.defaultDesktopPageMargin : AppSizes.defaultMobilePageMargin,
        child: Column(
          children: const <Widget>[
            ColumnRowSwapper(
              expandOnRow: true,
              children: <Widget>[
                KiraCard(
                  child: DashboardGridTile.icon(
                    title: 'speedwagon_rr',
                    subtitle: 'Current Block Validator',
                    icon: Icon(
                      AppIcons.block,
                      color: Color(0xFFF44082),
                    ),
                  ),
                ),
                ColumnRowSpacer(size: 32),
                KiraCard(
                  child: DashboardGridTile.icon(
                    title: '79%',
                    subtitle: 'Consensus',
                    icon: Icon(
                      AppIcons.consensus,
                      color: Color(0xFFD429FF),
                    ),
                  ),
                ),
                ColumnRowSpacer(size: 32),
                KiraCard(
                  child: DashboardGridTile.icon(
                    title: 'Healthy',
                    subtitle: 'Consensus state',
                    icon: Icon(
                      AppIcons.health,
                      color: Color(0xFFF2E46C),
                    ),
                  ),
                ),
              ],
            ),
            DashboardGrid(
              title: 'Validators',
              columnsCount: 6,
              mobileColumnsCount: 2,
              tabletColumnsCount: 3,
              items: <DashboardGridTile>[
                DashboardGridTile(
                  title: '566',
                  subtitle: 'Total',
                ),
                DashboardGridTile(
                  title: '262',
                  subtitle: 'Active',
                ),
                DashboardGridTile(
                  title: '26',
                  subtitle: 'Inactive',
                ),
                DashboardGridTile(
                  title: '22',
                  subtitle: 'Jailed',
                ),
                DashboardGridTile(
                  title: '11',
                  subtitle: 'Paused',
                ),
                DashboardGridTile(
                  title: '4',
                  subtitle: 'Waiting',
                ),
              ],
            ),
            ColumnRowSwapper(
              expandOnRow: true,
              children: <Widget>[
                DashboardGrid(
                  title: 'Blocks',
                  columnsCount: 2,
                  items: <DashboardGridTile>[
                    DashboardGridTile(
                      title: '1234',
                      subtitle: 'Current height',
                    ),
                    DashboardGridTile(
                      title: '1234',
                      subtitle: 'Since genesis',
                    ),
                    DashboardGridTile(
                      title: '11',
                      subtitle: 'Pending transactions',
                    ),
                    DashboardGridTile(
                      title: '566',
                      subtitle: 'current transactions',
                    ),
                    DashboardGridTile(
                      title: '4,1 sec',
                      subtitle: 'Latest time',
                    ),
                    DashboardGridTile(
                      title: '3,8 sec',
                      subtitle: 'Average time',
                    ),
                  ],
                ),
                ColumnRowSpacer(size: 32),
                DashboardGrid(
                  title: 'Proposals',
                  columnsCount: 2,
                  items: <DashboardGridTile>[
                    DashboardGridTile(
                      title: '262/566',
                      subtitle: 'Active',
                    ),
                    DashboardGridTile(
                      title: '26',
                      subtitle: 'Enacting',
                    ),
                    DashboardGridTile(
                      title: '62',
                      subtitle: 'Finished',
                    ),
                    DashboardGridTile(
                      title: '2',
                      subtitle: 'Successfull',
                    ),
                    DashboardGridTile(
                      title: '262/566',
                      subtitle: 'Proposers',
                    ),
                    DashboardGridTile(
                      title: '211',
                      subtitle: 'Voters',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 36),
            Spacer(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
