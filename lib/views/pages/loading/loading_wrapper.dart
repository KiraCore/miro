import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/kira/kira_background.dart';

class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KiraBackground(
      child: AutoRouter(),
    );
  }
}
