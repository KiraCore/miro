import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraCheckboxListTile extends StatefulWidget {
  final String title;
  final bool initialValue;
  final void Function(bool) onChanged;

  const KiraCheckboxListTile({
    required this.title,
    required this.onChanged,
    this.initialValue = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraCheckboxListTile();
}

class _KiraCheckboxListTile extends State<KiraCheckboxListTile> {
  late bool checked = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _onCheckboxStateChanged,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _KiraCheckbox(
              onChanged: _onCheckboxStateChanged,
              checked: checked,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: DesignColors.gray2_100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCheckboxStateChanged() {
    setState(() {
      checked = !checked;
    });
    widget.onChanged(checked);
  }
}

class _KiraCheckbox extends StatelessWidget {
  final bool checked;
  final void Function() onChanged;

  const _KiraCheckbox({
    required this.onChanged,
    this.checked = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: SizedBox(
        width: 25,
        height: 25,
        child: Center(
          child: checked
              ? const Icon(AppIcons.checkbox_checked, color: DesignColors.blue2_100)
              : const Icon(AppIcons.checkbox_empty, color: DesignColors.gray2_100),
        ),
      ),
    );
  }
}
