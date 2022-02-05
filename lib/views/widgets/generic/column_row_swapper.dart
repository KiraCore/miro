import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive_widget.dart';

class ColumnRowSwapper extends StatefulWidget {
  final List<Widget> children;
  final bool expandOnRow;
  final bool expandOnColumn;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;

  const ColumnRowSwapper({
    required this.children,
    this.expandOnRow = false,
    this.expandOnColumn = false,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnRowSwapper();
}

class _ColumnRowSwapper extends State<ColumnRowSwapper> {
  bool get isRow {
    return ResponsiveWidget.isLargeScreen(context);
  }

  bool get isColumn {
    return !isRow;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Row(
        mainAxisAlignment: widget.rowMainAxisAlignment,
        crossAxisAlignment: widget.rowCrossAxisAlignment,
        children: _buildChildren(),
      ),
      mediumScreen: Column(
        mainAxisAlignment: widget.columnMainAxisAlignment,
        crossAxisAlignment: widget.columnCrossAxisAlignment,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    if (!widget.expandOnColumn && !widget.expandOnRow) {
      return widget.children;
    }
    if (isColumn && !widget.expandOnColumn) {
      return widget.children;
    }
    if (isRow && !widget.expandOnRow) {
      return widget.children;
    }
    return widget.children.map((Widget e) {
      if (e is ColumnRowSpacer) {
        return e;
      }
      return Expanded(
        child: e,
      );
    }).toList();
  }
}
