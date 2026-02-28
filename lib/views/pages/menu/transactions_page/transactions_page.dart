import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/pages/menu/transactions_page/transactions_page_sliver.dart';

@RoutePage()
class TransactionsPage extends StatelessWidget {
  final BlockModel? blockModel;

  const TransactionsPage({
    Key? key,
    this.blockModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        TransactionsPageSliver(blockModel: blockModel, scrollController: scrollController),
      ],
    );
  }
}
