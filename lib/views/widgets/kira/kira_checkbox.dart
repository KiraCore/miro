import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;

  const KiraCheckbox({
    required this.onChanged,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraCheckbox();
}

class _KiraCheckbox extends State<KiraCheckbox> {
  late bool checked = widget.value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleCheckboxChanged,
      child: Container(
        padding: const EdgeInsets.all(2),
        child: Icon(
          checked ? AppIcons.checkbox_checked : AppIcons.checkbox_empty,
          size: 18,
          color: DesignColors.blue1_100,
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
