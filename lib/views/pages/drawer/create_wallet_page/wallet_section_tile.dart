import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class WalletSectionTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? tooltipMessage;
  final List<Widget> children;
  final bool disabled;

  const WalletSectionTile({
    required this.title,
    required this.children,
    this.subtitle,
    this.tooltipMessage,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletSectionTile();
}

class _WalletSectionTile extends State<WalletSectionTile> {
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
            color: expandedStatus ? DesignColors.blue1_100 : const Color(0xFF4E4C71),
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Theme(
          data: ThemeData().copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ExpansionTile(
            onExpansionChanged: (bool expanded) => setState(() {
              expandedStatus = expanded;
            }),
            title: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: DesignColors.white_100,
                  ),
                ),
                if (widget.tooltipMessage != null)
                  KiraToolTip(
                    message: widget.tooltipMessage!,
                  ),
              ],
            ),
            subtitle: widget.subtitle != null
                ? Text(
                    widget.subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: DesignColors.yellow_100,
                    ),
                  )
                : null,
            collapsedIconColor: DesignColors.white_100,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
