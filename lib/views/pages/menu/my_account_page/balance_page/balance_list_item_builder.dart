import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/token_utils.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

typedef ExpansionChangedCallback = void Function(bool status);
typedef FavouritePressedCallback = void Function(bool value);

class BalanceListItemBuilder extends StatefulWidget {
  final Balance balance;

  const BalanceListItemBuilder({
    required this.balance,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BalanceListItemBuilder();
}

class _BalanceListItemBuilder extends State<BalanceListItemBuilder> {
  final FavouriteCache favouriteCache = FavouriteCache(
    boxName: BalanceListBloc.favouriteCacheWorkspace,
  );
  bool isExpanded = false;

  bool get isFavourite {
    return favouriteCache.get(id: widget.balance.denom);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: () {},
      selected: isExpanded,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(states),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isExpanded ? DesignColors.blue1_100 : Colors.transparent,
              width: 1,
            ),
          ),
          child: FutureBuilder<TokenAlias?>(
            future: _getTokenAlias(),
            builder: (BuildContext context, AsyncSnapshot<TokenAlias?> snapshot) {
              TokenAlias? tokenAlias = snapshot.data;
              tokenAlias ??= TokenAlias(
                decimals: 0,
                icon: '',
                amount: '0',
                name: 'undefined',
                symbol: widget.balance.denom,
                denoms: <String>[widget.balance.denom],
              );

              return ResponsiveWidget(
                largeScreen: BalanceListItemDesktop(
                  expansionChangedCallback: _onExpansionChanged,
                  mouseStates: states,
                  favourite: isFavourite,
                  tokenName: _getTokenName(tokenAlias),
                  tokenSymbol: _getTokenSymbol(tokenAlias),
                  tokenAmountText: _getTokenAmountText(tokenAlias),
                  lowestDenominationText: _getTokenLowestDenominationText(),
                  fullTokenAmountText: _getTokenFullAmountText(),
                  favouritePressedCallback: _onFavouriteButtonPressed,
                  tokenIcon: tokenAlias.icon,
                  onSendPressed: () => _onSendPressed(tokenAlias!),
                ),
                mediumScreen: BalanceListItemMobile(
                  expansionChangedCallback: _onExpansionChanged,
                  mouseStates: states,
                  favourite: isFavourite,
                  tokenName: _getTokenName(tokenAlias),
                  tokenSymbol: _getTokenSymbol(tokenAlias),
                  tokenAmountText: _getTokenAmountText(tokenAlias),
                  lowestDenominationText: _getTokenLowestDenominationText(),
                  fullTokenAmountText: _getTokenFullAmountText(),
                  favouritePressedCallback: _onFavouriteButtonPressed,
                  tokenIcon: tokenAlias.icon,
                  onSendPressed: () => _onSendPressed(tokenAlias!),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onSendPressed(TokenAlias tokenAlias) {
    AutoRouter.of(context).navigate(DialogWrapperRoute(children: <PageRouteInfo>[
      TransactionCreateRoute(
        messageType: 'MsgSend',
        metadata: <String, dynamic>{
          'tokenAlias': tokenAlias,
        },
      ),
    ]));
  }

  Color _getBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.selected)) {
      return const Color(0x1A344AE6);
    }
    return Colors.transparent;
  }

  Future<TokenAlias?> _getTokenAlias() async {
    TokensProvider tokensProvider = globalLocator<TokensProvider>();
    TokenAlias? tokenAlias;
    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = await tokensProvider.getQueryKiraTokensAliasesResp();
      tokenAlias = queryKiraTokensAliasesResp.tokenAliases.firstWhere((TokenAlias e) {
        return e.denoms.contains(widget.balance.denom);
      });
    } catch (_) {
      // Do nothing, because TokenRate is not required to be not null
      // and firstWhere() method throws [IterableElementError.noElement()] every single time when data not found
    }
    return tokenAlias;
  }

  void _onFavouriteButtonPressed(bool value) {
    if (value) {
      favouriteCache.add(id: widget.balance.denom, value: true);
    } else {
      favouriteCache.delete(id: widget.balance.denom);
    }
    BlocProvider.of<BalanceListBloc>(context).add(SortEvent<Balance>());
    setState(() {});
  }

  void _onExpansionChanged(bool value) {
    if (value != isExpanded) {
      setState(() {
        isExpanded = value;
      });
    }
  }

  String _getTokenSymbol(TokenAlias? tokenAlias) {
    return tokenAlias?.symbol ?? widget.balance.denom;
  }

  String _getTokenName(TokenAlias? tokenAlias) {
    return tokenAlias?.name ?? 'unknown';
  }

  String _getTokenAmountText(TokenAlias tokenAlias) {
    String amount = TokenUtils.changeDenomination(
      amount: widget.balance.amount,
      fromDenomination: widget.balance.denom,
      toDenomination: tokenAlias.symbol,
      tokenAlias: tokenAlias,
    );
    return amount;
  }

  String _getTokenLowestDenominationText() {
    return widget.balance.denom;
  }

  String _getTokenFullAmountText() {
    return widget.balance.amount;
  }
}
