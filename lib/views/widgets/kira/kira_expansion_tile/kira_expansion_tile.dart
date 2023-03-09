import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/expansion_tile_title.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile_controller.dart';

class KiraExpansionTile extends StatefulWidget {
  final KiraExpansionTileController? controller;
  final String title;
  final String? subtitle;
  final String? tooltipMessage;
  final List<Widget> children;
  final bool disabled;

  const KiraExpansionTile({
    required this.title,
    required this.children,
    this.controller,
    this.subtitle,
    this.tooltipMessage,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraExpansionTile();
}

class _KiraExpansionTile extends State<KiraExpansionTile> {
  late final KiraExpansionTileController controller = widget.controller ?? KiraExpansionTileController();
  bool expandedStatus = false;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.disabled ? 0.3 : 1,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: expandedStatus ? DesignColors.white1 : DesignColors.greyOutline,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ExpansionTile(
            key: controller.expansionTileGlobalKey,
            onExpansionChanged: _onExpansionChanged,
            maintainState: true,
            initiallyExpanded: expandedStatus,
            title: ExpansionTileTitle(
              title: widget.title,
              tooltipMessage: widget.tooltipMessage,
            ),
            subtitle: _buildSubtitle(),
            iconColor: DesignColors.white1,
            children: widget.children,
          ),
        ),
      ),
    );
  }

  void _onExpansionChanged(bool status) {
    expandedStatus = status;
    controller.notifyExpansionChanged();
    setState(() {});
  }

  Widget? _buildSubtitle() {
    if (widget.subtitle != null) {
      return Text(
        widget.subtitle!,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: DesignColors.yellowStatus1,
        ),
      );
    }
    return null;
  }
}
