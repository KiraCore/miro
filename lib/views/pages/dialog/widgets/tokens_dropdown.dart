import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/token_avatar.dart';

enum TokensDropdownType {
  allBalances,
  availableBalances,
}

class TokenDropdownController {
  late void Function() reset;

  void _initController({
    required void Function() reset,
  }) {
    this.reset = reset;
  }
}

class TokensDropdown extends StatefulWidget {
  final TokenDropdownController controller;
  final TokenAlias? initialValue;
  final TokensDropdownType tokensDropdownType;
  final List<Balance>? balances;
  final void Function(TokenAlias) onTokenChanged;

  const TokensDropdown({
    required this.controller,
    required this.tokensDropdownType,
    required this.onTokenChanged,
    this.initialValue,
    this.balances,
    Key? key,
  })  : assert(
            tokensDropdownType == TokensDropdownType.allBalances ||
                (tokensDropdownType == TokensDropdownType.availableBalances && balances != null),
            'Displaying available balances requires balances to be provided'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _TokensDropdown();
}

class _TokensDropdown extends State<TokensDropdown> {
  late TokenAlias? _selectedToken = widget.initialValue;
  PopWrapperController popWrapperController = PopWrapperController();

  List<TokenAlias> availableTokenAliases = List<TokenAlias>.empty(growable: true);
  bool loadingStatus = false;

  @override
  void initState() {
    widget.controller._initController(reset: reset);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TokensDropdown oldWidget) {
    if (oldWidget.balances != widget.balances) {
      _fetchDropdownData();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return PopWrapper(
          disabled: _selectedToken == null,
          buttonWidth: constraints.maxWidth,
          buttonHeight: constraints.maxHeight,
          popWrapperController: popWrapperController,
          buttonBuilder: _buildButton,
          dropdownMargin: 0,
          decoration: BoxDecoration(
            color: const Color(0xFF12143D),
            borderRadius: BorderRadius.circular(8),
          ),
          popupBuilder: () => _buildPopupContent(constraints),
        );
      },
    );
  }

  void reset() {
    setState(() {
      availableTokenAliases.clear();
      _selectedToken = null;
    });
  }

  Future<void> _fetchDropdownData() async {
    _setLoadingStatus(status: true);
    availableTokenAliases.clear();
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp =
        await globalLocator<TokensProvider>().getQueryKiraTokensAliasesResp();
    if (widget.tokensDropdownType == TokensDropdownType.allBalances) {
      availableTokenAliases = queryKiraTokensAliasesResp.tokenAliases;
    } else {
      for (Balance balance in widget.balances!) {
        TokenAlias tokenAlias = _getTokenAliasForBalance(queryKiraTokensAliasesResp, balance);
        availableTokenAliases.add(tokenAlias);
      }
    }
    if (availableTokenAliases.isNotEmpty) {
      _selectedToken ??= availableTokenAliases.first;
      widget.onTokenChanged(_selectedToken!);
    }
    _setLoadingStatus(status: false);
  }

  TokenAlias _getTokenAliasForBalance(QueryKiraTokensAliasesResp queryKiraTokensAliasesResp, Balance balance) {
    return queryKiraTokensAliasesResp.tokenAliases.firstWhere(
      (TokenAlias tokenAlias) => tokenAlias.symbol == balance.denom || tokenAlias.lowestDenomination == balance.denom,
      orElse: () {
        return TokenAlias(
          decimals: 0,
          denoms: <String>[balance.denom],
          name: balance.denom,
          symbol: balance.denom,
          icon: '',
          amount: '0',
        );
      },
    );
  }

  void _setLoadingStatus({required bool status}) {
    if (mounted && status != loadingStatus) {
      setState(() {
        loadingStatus = status;
      });
    }
  }

  Widget _buildButton(AnimationController animationController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Token',
          style: TextStyle(fontSize: 10, color: DesignColors.gray2_100),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            TokenAvatar(
              size: 19,
              tokenIcon: _selectedToken?.icon,
            ),
            const SizedBox(width: 6),
            Text(
              _selectedToken?.symbol ?? '---',
              style: const TextStyle(color: DesignColors.white_100),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopupContent(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: constraints.maxWidth + 20,
      height: 150,
      child: loadingStatus
          ? const CenterLoadSpinner()
          : _DropdownContent(
              onListItemTap: _onListItemTap,
              tokenAliases: availableTokenAliases,
            ),
    );
  }

  void _onListItemTap(TokenAlias tokenAlias) {
    popWrapperController.toggleMenu();
    setState(() {
      _selectedToken = tokenAlias;
      widget.onTokenChanged(tokenAlias);
    });
  }
}

typedef AliasSelectedCallback = void Function(TokenAlias tokenAlias);

class _DropdownContent extends StatelessWidget {
  final AliasSelectedCallback onListItemTap;
  final List<TokenAlias> tokenAliases;

  const _DropdownContent({
    required this.onListItemTap,
    required this.tokenAliases,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tokenAliases.length,
      itemBuilder: (BuildContext context, int index) {
        TokenAlias tokenAlias = tokenAliases[index];
        return ListTile(
          onTap: () => onListItemTap(tokenAlias),
          leading: TokenAvatar(
            size: 25,
            tokenIcon: tokenAlias.icon,
          ),
          title: Text(
            tokenAlias.symbol,
            style: const TextStyle(
              color: DesignColors.white_100,
            ),
          ),
        );
      },
    );
  }
}
