import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/transactions_page/transactions_page_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_filter_options.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/utils/extensions/date_time_extension.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/transaction_list_item_builder.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_title/transaction_list_title.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class BlocksDrawerPage extends StatefulWidget {
  final BlockModel blockModel;

  const BlocksDrawerPage({required this.blockModel, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocksDrawerPage();
}

class _BlocksDrawerPage extends State<BlocksDrawerPage> {
  final NetworkCustomSectionCubit _networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();

  @override
  void dispose() {
    _networkCustomSectionCubit.resetSwitchValueWhenConnected();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(child: _MainContent(blockModel: widget.blockModel)),
        _TransactionsPage(blockModel: widget.blockModel),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
      ],
    );
  }
}

// todo
class _MainContent extends StatelessWidget {
  final BlockModel blockModel;

  const _MainContent({required this.blockModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWrapper(
                onTap: () => Navigator.pop(context),
                padding: const EdgeInsets.all(12),
                borderRadius: BorderRadius.circular(150),
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: DesignColors.white1,
                  size: 50,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 14),
                  DrawerTitle(
                    title: '${S.of(context).block} ${blockModel.header.height}',
                  ),
                  Text(
                    blockModel.header.time.toAgeAgo(context),
                    style: const TextStyle(
                      color: DesignColors.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _CommonDetails(blockModel: blockModel),
          ),
        ],
      ),
    );
  }
}

class _CommonDetails extends StatelessWidget {
  const _CommonDetails({required this.blockModel});

  final BlockModel blockModel;

  @override
  Widget build(BuildContext context) {
    Widget divider = const SizedBox(height: 24);
    Widget rowDivider = const SizedBox(width: 24);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Title(S.of(context).blocksProposer),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CopyButton(
                        value: blockModel.header.proposerAddress,
                        notificationText: S.of(context).toastSuccessfullyCopied,
                      ),
                      const SizedBox(width: 4),
                      KiraIdentityAvatar(
                        address: blockModel.header.proposerAddress,
                        size: 24,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: KiraToolTip(
                          childMargin: EdgeInsets.zero,
                          message: blockModel.header.proposerAddress,
                          child: _Value(blockModel.header.proposerAddress),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            rowDivider,
            Expanded(
              child: _CopyHoverTitleValue(title: S.of(context).blocksChainId, value: blockModel.header.chainId),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: _CopyHoverTitleValue(title: S.of(context).blocksHash, value: blockModel.blockId.hash),
            ),
            rowDivider,
            Expanded(
              child: _CopyHoverTitleValue(
                  title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: _CopyHoverTitleValue(title: S.of(context).blocksAppHash, value: blockModel.header.appHash),
            ),
            rowDivider,
            Expanded(
              child: _CopyHoverTitleValue(
                  title: S.of(context).blocksConsensusHash, value: blockModel.header.consensusHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child:
                  _CopyHoverTitleValue(title: S.of(context).blocksEvidenceHash, value: blockModel.header.evidenceHash),
            ),
            rowDivider,
            Expanded(
              child: _CopyHoverTitleValue(
                  title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Title(S.of(context).blocksBlockSize),
                  const SizedBox(height: 4),
                  _Value(blockModel.blockSize.toString()),
                ],
              ),
            ),
            rowDivider,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Title(S.of(context).blocksTxCount),
                  const SizedBox(height: 4),
                  _Value(blockModel.numTxs.toString()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CopyHoverTitleValue extends StatelessWidget {
  const _CopyHoverTitleValue({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Title(title),
        const SizedBox(height: 4),
        _CopyHoverValue(value: value),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return Text('${title}:', style: headerStyle);
  }
}

class _Value extends StatelessWidget {
  const _Value(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle valueStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);

    return Text(value, overflow: TextOverflow.ellipsis, style: valueStyle);
  }
}

class _CopyHoverValue extends StatelessWidget {
  const _CopyHoverValue({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CopyButton(
          value: value,
          notificationText: S.of(context).toastSuccessfullyCopied,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: KiraToolTip(
            childMargin: EdgeInsets.zero,
            message: value,
            child: _Value(value),
          ),
        ),
      ],
    );
  }
}

// todo reuse
class _TransactionsPage extends StatefulWidget {
  const _TransactionsPage({
    required this.blockModel,
    Key? key,
  }) : super(key: key);

  final BlockModel blockModel;

  @override
  State<StatefulWidget> createState() => __TransactionsPage();
}

class __TransactionsPage extends State<_TransactionsPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late final TransactionsListController transactionsListController;
  final FiltersBloc<TxListItemModel> filtersBloc = FiltersBloc<TxListItemModel>(
    searchComparator: TransactionsFilterOptions.search,
  );
  int pageSize = 15;

  @override
  void initState() {
    super.initState();
    transactionsListController = TransactionsListController()..blockModel = widget.blockModel;
  }

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    scrollController.dispose();
    filtersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return BlocProvider<TransactionsPageCubit>(
      create: (BuildContext context) => TransactionsPageCubit(),
      child: BlocBuilder<TransactionsPageCubit, TransactionsPageState>(
        builder: (BuildContext context, TransactionsPageState state) {
          Widget listHeaderWidget = TransactionListItemDesktopLayout(
            height: 64,
            hashWidget: Text(S.of(context).txnListHash, style: headerStyle),
            methodWidget: Text(S.of(context).txListMethod, style: headerStyle),
            dateWidget: InkWell(
              onTap: () => context.read<TransactionsPageCubit>().switchDateFormat(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  state.isAgeFormatBool ? S.of(context).txListAge : S.of(context).txListDate,
                  style: headerStyle.copyWith(color: DesignColors.hyperlink),
                ),
              ),
            ),
            isDateInAgeFormatBool: state.isAgeFormatBool,
            fromWidget: Text(S.of(context).txListFrom, style: headerStyle),
            toWidget: Text(S.of(context).txListTo, style: headerStyle),
            amountWidget: Text(S.of(context).txListAmount, style: headerStyle),
            feeWidget: Text(S.of(context).txnListFee, style: headerStyle),
          );

          return SliverPadding(
            padding: AppSizes.getPagePadding(context),
            sliver: SliverPaginatedList<TxListItemModel>(
              desktopItemHeight: 80,
              listController: transactionsListController,
              scrollController: scrollController,
              singlePageSize: pageSize,
              hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
              listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
              filtersBloc: filtersBloc,
              titleBuilder: (BuildContext context) {
                return TransactionListTitle(
                  searchBarTextEditingController: searchBarTextEditingController,
                  transactionsListController: transactionsListController,
                  // hasTitle: false,
                );
              },
              itemBuilder: (TxListItemModel txListItemModel) => TransactionListItemBuilder(
                key: Key(txListItemModel.toString()),
                txListItemModel: txListItemModel,
                scrollController: scrollController,
                isAgeFormatBool: state.isAgeFormatBool,
              ),
            ),
          );
        },
      ),
    );
  }
}
