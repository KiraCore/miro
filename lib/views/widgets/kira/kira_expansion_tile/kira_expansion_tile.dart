import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/controllable_expansion_tile.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/expansion_tile_title.dart';
import 'package:miro/views/widgets/kira/kira_expansion_tile/kira_expansion_tile_controller.dart';

class KiraExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final KiraExpansionTileController kiraExpansionTileController;
  final bool disabled;
  final String? subtitle;
  final String? tooltipMessage;

  const KiraExpansionTile({
    required this.title,
    required this.children,
    required this.kiraExpansionTileController,
    this.disabled = false,
    this.subtitle,
    this.tooltipMessage,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraExpansionTile();
}

class _KiraExpansionTile extends State<KiraExpansionTile> {
  bool expandedBool = false;

  @override
  void initState() {
    super.initState();
    widget.kiraExpansionTileController.addListener(_updateVisibility);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.disabled ? 0.3 : 1,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: expandedBool ? DesignColors.white1 : DesignColors.greyOutline,
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
          child: ControllableExpansionTile(
            key: widget.kiraExpansionTileController.expansionTileGlobalKey,
            onExpansionChanged: (_) => widget.kiraExpansionTileController.notifyExpansionChanged(),
            maintainState: true,
            initiallyExpanded: expandedBool,
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

  void _updateVisibility() {
    if (mounted) {
      setState(() {
        expandedBool = widget.kiraExpansionTileController.isExpanded;
      });
    }
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
