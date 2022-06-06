import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_background.dart';

class DialogWrapper extends StatelessWidget {
  const DialogWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => _closeDialog(context),
            icon: const Icon(
              Icons.close,
              color: DesignColors.gray2_100,
            ),
          ),
        ),
        body: const AutoRouter(),
      ),
    );
  }

  void _closeDialog(BuildContext context) {
    if (context.router.canPopSelfOrChildren) {
      context.router.pop();
    } else {
      context.router.replaceNamed('/');
    }
  }
}
