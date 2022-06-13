import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';

class IdentityRecordRowLayout extends StatelessWidget {
  final Widget entrySection;
  final Widget statusSection;
  final Widget actionsSection;
  final EdgeInsets padding;
  final BoxDecoration? decoration;
  final String? warningMessage;

  const IdentityRecordRowLayout({
    required this.entrySection,
    required this.statusSection,
    required this.actionsSection,
    required this.padding,
    this.decoration,
    this.warningMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (warningMessage != null) ...<Widget>[
                    StatusChip(
                      type: StatusChipType.warning,
                      icon: const Icon(AppIcons.info),
                      label: warningMessage!,
                    ),
                    const SizedBox(height: 8),
                  ],
                  entrySection,
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: statusSection,
            ),
          ),
          Expanded(
            child: actionsSection,
          ),
        ],
      ),
    );
  }
}
