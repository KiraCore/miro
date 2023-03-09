import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;
  final double? size;

  const KiraCheckbox({
    required this.onChanged,
    required this.value,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraCheckbox();
}

class _KiraCheckbox extends State<KiraCheckbox> {
  late bool checked = widget.value;
  late double? size = widget.size;

  @override
  void didUpdateWidget(covariant KiraCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      checked = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleCheckboxChanged,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: Icon(
          checked ? AppIcons.checkbox_checked : AppIcons.checkbox_empty,
          size: size ?? 18,
          color: checked ? DesignColors.white1 : DesignColors.accent,
        ),
      ),
    );
  }

  void _handleCheckboxChanged() {
    checked = !checked;
    widget.onChanged.call(checked);
    setState(() {});
  }
}
