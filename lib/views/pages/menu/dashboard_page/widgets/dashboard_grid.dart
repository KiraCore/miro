import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_tile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_card.dart';

class DashboardGrid extends StatefulWidget {
  final String title;
  final int columnsCount;
  final int? tabletColumnsCount;
  final int? mobileColumnsCount;
  final List<DashboardGridTile> items;

  const DashboardGrid({
    required this.title,
    required this.columnsCount,
    required this.items,
    this.tabletColumnsCount,
    this.mobileColumnsCount,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardGrid();
}

class _DashboardGrid extends State<DashboardGrid> {
  late int finalColumnsCount;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    _initColumnsCount();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Text(
                widget.title,
                style: textTheme.headline2!.copyWith(
                  color: DesignColors.white_100,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  AppIcons.chevron_right,
                  size: 20,
                  color: DesignColors.gray2_100,
                ),
              ),
            ],
          ),
        ),
        KiraCard(
          child: Column(
            children: _buildRows(),
          ),
        ),
      ],
    );
  }

  void _initColumnsCount() {
    if (ResponsiveWidget.isMediumScreen(context) && widget.tabletColumnsCount != null) {
      finalColumnsCount = widget.tabletColumnsCount!;
    } else if (ResponsiveWidget.isSmallScreen(context) && widget.mobileColumnsCount != null) {
      finalColumnsCount = widget.mobileColumnsCount!;
    } else {
      finalColumnsCount = widget.columnsCount;
    }
  }

  List<Widget> _buildRows() {
    List<Widget> rows = List<Widget>.empty(growable: true);
    int rowsCount = (widget.items.length / finalColumnsCount).round();
    for (int i = 0; i < rowsCount; i++) {
      rows.add(
        Row(children: _buildRow(i)),
      );
    }
    return rows;
  }

  List<Widget> _buildRow(int index) {
    List<Widget> cells = List<Widget>.empty(growable: true);
    for (int i = 0; i < finalColumnsCount; i++) {
      int currentItemIndex = index * finalColumnsCount + i;
      cells.add(
        Expanded(child: widget.items[currentItemIndex]),
      );
    }
    return cells;
  }
}
