import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';

class ReportIssuesButton extends StatelessWidget {
  const ReportIssuesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: double.infinity,
      child: OutlinedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(_setForegroundColor),
          overlayColor: MaterialStateProperty.resolveWith(_setOverlayColor),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        ),
        onPressed: () => BrowserController.openUrl('https://report.kira.network/'),
        icon: const Icon(Icons.bug_report_outlined),
        label: Text(S.of(context).buttonReportIssues),
      ),
    );
  }

  Color _setForegroundColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return DesignColors.white1;
    }
    return DesignColors.redStatus1;
  }

  Color _setOverlayColor(Set<MaterialState> states) {
    return DesignColors.greyHover2;
  }
}
