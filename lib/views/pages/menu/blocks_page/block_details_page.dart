import 'package:flutter/material.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/pages/menu/blocks_page/widgets/block_details_widget.dart';
import 'package:miro/views/pages/menu/transactions_page/transactions_page_sliver.dart';

class BlockDetailsPage extends StatelessWidget {
  final BlockModel blockModel;

  const BlockDetailsPage({required this.blockModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(child: BlockDetailsWidget(blockModel: blockModel)),
        TransactionsPageSliver(blockModel: blockModel, scrollController: scrollController),
      ],
    );
  }
}
