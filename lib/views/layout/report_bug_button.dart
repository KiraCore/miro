import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';

class ReportBugButton extends StatelessWidget {
  const ReportBugButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: double.infinity,
      child: OutlinedButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(DesignColors.red_100),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        ),
        onPressed: () => BrowserController.openUrl('https://forms.gle/mFysxpo1ZPKVkYyu5'),
        icon: const Icon(Icons.bug_report_outlined),
        label: const Text('Report bug'),
      ),
    );
  }
}
