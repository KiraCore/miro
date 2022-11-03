import 'package:flutter/material.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TODO(dominik): Dev view. Remove it before merge (or before implement this view)
          KiraElevatedButton(
            width: 200,
            onPressed: () {
              KiraToast.of(context).show(message: 'Warning: This is warning toast', type: ToastType.warning);
            },
            title: 'Show warning toast',
          ),
          const SizedBox(height: 8),
          KiraElevatedButton(
            width: 200,
            onPressed: () {
              KiraToast.of(context).show(message: 'Error: This is error toast', type: ToastType.error);
            },
            title: 'Show error toast',
          ),
          const SizedBox(height: 8),
          KiraElevatedButton(
            width: 200,
            onPressed: () {
              KiraToast.of(context).show(message: 'Success: This is success toast', type: ToastType.success);
            },
            title: 'Show success toast',
          ),
          const SizedBox(height: 8),
          KiraElevatedButton(
            width: 200,
            onPressed: () {
              KiraToast.of(context).show(message: 'Note: This is default toast', type: ToastType.normal);
            },
            title: 'Show default toast',
          ),
        ],
      ),
    );
  }
}
