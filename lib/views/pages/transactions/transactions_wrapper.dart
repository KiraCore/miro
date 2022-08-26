import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_background.dart';
import 'package:miro/views/widgets/transactions/tx_app_bar.dart';

class TransactionsWrapper extends StatelessWidget {
  const TransactionsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KiraBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Padding(
                  padding: ResponsiveWidget.isSmallScreen(context) ? const EdgeInsets.only(top: 80) : EdgeInsets.zero,
                  child: const AutoRouter(),
                ),
              ),
              const TxAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
