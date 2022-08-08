import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class NetworkCustomSectionSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool initialExpanded;

  const NetworkCustomSectionSwitch({
    required this.onChanged,
    this.initialExpanded = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSectionSwitch();
}

class _NetworkCustomSectionSwitch extends State<NetworkCustomSectionSwitch> {
  late bool switchStatus = widget.initialExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Enable custom address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: DesignColors.white_100,
            ),
          ),
          Switch(
            value: switchStatus,
            onChanged: _handleSwitchChanged,
          ),
        ],
      ),
    );
  }

  void _handleSwitchChanged(bool value) {
    switchStatus = value;
    widget.onChanged(value);
    setState(() {});
  }
}
