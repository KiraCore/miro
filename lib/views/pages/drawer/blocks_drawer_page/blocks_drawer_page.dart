import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/extensions/date_time_extension.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/mobile/transaction_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          // todo
          title: 'Block ${widget.blockModel.header.height}',
        ),
        Text(
          // todo
          '${widget.blockModel.header.time.toShortAgeAgo(context)} ago',
          style: const TextStyle(
            color: DesignColors.accent,
          ),
        ),
        const SizedBox(height: 32),
        _CommonDetails(blockModel: widget.blockModel),
        const SizedBox(height: 24),
        if (widget.blockModel.numTxs == 0) ...<Widget>[
          const Divider(),
          const SizedBox(height: 8),
          _Details(blockModel: widget.blockModel),
          const SizedBox(height: 48),
        ],
      ],
    );
  }
}

class _CommonDetails extends StatelessWidget {
  const _CommonDetails({required this.blockModel});

  final BlockModel blockModel;

  @override
  Widget build(BuildContext context) {
    Widget divider = const SizedBox(height: 16);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Title(S.of(context).blocksProposer),
            const SizedBox(height: 4),
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
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksChainId, value: blockModel.header.chainId),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksHash, value: blockModel.blockId.hash),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksAppHash, value: blockModel.header.appHash),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksConsensusHash, value: blockModel.header.consensusHash),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksEvidenceHash, value: blockModel.header.evidenceHash),
        divider,
        _CopyHoverTitleValue(title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
        divider,
        _Title(S.of(context).blocksBlockSize),
        const SizedBox(height: 4),
        _Value(blockModel.blockSize.toString()),
        divider,
        _Title(S.of(context).blocksTxCount),
        const SizedBox(height: 4),
        _Value(blockModel.numTxs.toString()),
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.blockModel});

  final BlockModel blockModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Widget content;
    // Widget divider = const SizedBox(height: 12);
    TransactionsListController transactionsListController = TransactionsListController()
      ..blockId = blockModel.blockId.hash; // todo does if fetches

    // todo for test
    TxListItemModel txListItemModel = TxListItemModel(
      hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA',
      time: DateTime.parse('2023-01-30 16:48:28.000'),
      txDirectionType: TxDirectionType.outbound,
      txStatusType: TxStatusType.confirmed,
      fees: <TokenAmountModel>[
        TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
      ],
      prefixedTokenAmounts: <PrefixedTokenAmountModel>[
        PrefixedTokenAmountModel(
          tokenAmountPrefixType: TokenAmountPrefixType.subtract,
          tokenAmountModel: TokenAmountModel(
              defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel),
        ),
      ],
      txMsgModels: <ATxMsgModel>[
        MsgSendModel(
            fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
            toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
            tokenAmountModel: TokenAmountModel(
                defaultDenominationAmount: Decimal.fromInt(100), tokenAliasModel: TestUtils.kexTokenAliasModel)),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // todo
          'Transactions:',
          style: textTheme.titleMedium!.copyWith(color: DesignColors.white2),
        ),
        const SizedBox(height: 12),
        // todo test
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: [txListItemModel, txListItemModel, txListItemModel].length,
        //   itemBuilder: (BuildContext context, int index) => TransactionListItemMobile(
        //     key: Key([txListItemModel, txListItemModel, txListItemModel][index].toString()),
        //     txListItemModel: [txListItemModel, txListItemModel, txListItemModel][index],
        //     isAgeFormatBool: false,
        //   ),
        // ),

        FutureBuilder<PageData<TxListItemModel>>(
            future:
                transactionsListController.getPageData(PaginationDetailsModel(offset: 0, limit: blockModel.blockSize)),
            builder: (BuildContext context, AsyncSnapshot<PageData<TxListItemModel>> snapshot) {
              if (snapshot.hasData) {
                PageData<TxListItemModel> pageData = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pageData.listItems.length,
                  itemBuilder: (BuildContext context, int index) => TransactionListItemMobile(
                    key: Key(pageData.listItems[index].toString()),
                    txListItemModel: pageData.listItems[index],
                    isAgeFormatBool: false,
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),

        // TODO: this doesn't work
        // CustomScrollView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   slivers: <Widget>[
        //     SliverPadding(
        //       padding: AppSizes.getPagePadding(context),
        //       sliver: SliverPaginatedList<TxListItemModel>(
        //         desktopItemHeight: 80,
        //         listController: transactionsListController,
        //         // scrollController: scrollController,
        //         singlePageSize: 20,
        //         hasBackgroundBool: false, // todo test
        //         listHeaderWidget: null,
        //         // titleBuilder: (BuildContext context) {
        //         //   return const SizedBox.shrink();
        //         // },
        //         itemBuilder: (TxListItemModel txListItemModel) => SizedBox(
        //           height: 100,
        //           width: 200,
        //           child: TransactionListItemBuilder(
        //             key: Key(txListItemModel.toString()),
        //             txListItemModel: txListItemModel,
        //             scrollController: ScrollController(),
        //             isAgeFormatBool: false,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
