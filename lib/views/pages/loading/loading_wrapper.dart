import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/kira/kira_background.dart';

@RoutePage(name: 'LoadingWrapperRoute')
class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: KiraBackground(
        child: AutoRouter(),
      ),
    );
  }
}
