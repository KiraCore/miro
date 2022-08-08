import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:provider/provider.dart';

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
  // TODO(dominik): List refactor
  // final FavouriteCache favouriteCache = FavouriteCache(
  //   boxName: BalanceListBloc.favouriteCacheWorkspace,
  // );
  bool isExpanded = false;

  bool get isFavourite {
    // TODO(dominik): List refactor
    // return favouriteCache.get(id: widget.balance.denom);
    return false;
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
          child: Consumer<TokensProvider>(
            builder: (_, TokensProvider tokensProvider, __) {
              TokenAlias? tokenAlias = _getTokenAlias(tokensProvider);
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
                  tokenIcon: tokenAlias?.icon ?? '',
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
                  tokenIcon: tokenAlias?.icon ?? '',
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color _getBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.selected)) {
      return const Color(0x1A344AE6);
    }
    return Colors.transparent;
  }

  TokenAlias? _getTokenAlias(TokensProvider tokensProvider) {
    TokenAlias? tokenAlias;
    try {
      tokenAlias = tokensProvider.queryKiraTokensAliasesResp!.tokenAliases.firstWhere((TokenAlias e) {
        return e.denoms.contains(widget.balance.denom);
      });
    } catch (_) {
      // Do nothing, because TokenRate is not required to be not null
      // and firstWhere() method throws [IterableElementError.noElement()] every single time when data not found
    }
    return tokenAlias;
  }

  void _onFavouriteButtonPressed(bool value) {
    // TODO(dominik): List refactor
    // if (value) {
    //   favouriteCache.add(id: widget.balance.denom, value: true);
    // } else {
    //   favouriteCache.delete(id: widget.balance.denom);
    // }
    // BlocProvider.of<BalanceListBloc>(context).add(SortEvent<Balance>());
    // setState(() {});
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

  String _getTokenAmountText(TokenAlias? tokenAlias) {
    // TODO(dominik): Remove it before release - START
    if (widget.balance.denom == 'AAB') {
      return '9999999999999999999.9999999999999999999999';
    }
    // TODO(dominik): Remove it before release - END
    try {
      double tokenAmount = double.parse(widget.balance.amount);
      int decimals = tokenAlias?.decimals ?? 0;
      double parsedTokenAmount = tokenAmount * pow(10, decimals * -1).toDouble();
      return '$parsedTokenAmount';
    } catch (e) {
      AppLogger().log(message: 'Cannot parse token amount: ${widget.balance.amount} ${widget.balance.denom}');
    }
    return widget.balance.amount;
  }

  String _getTokenLowestDenominationText() {
    return widget.balance.denom;
  }

  String _getTokenFullAmountText() {
    return widget.balance.amount;
  }
}
