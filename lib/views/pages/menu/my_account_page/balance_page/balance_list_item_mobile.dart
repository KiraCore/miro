import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';

class BalanceListItemMobile extends StatelessWidget {
  final ExpansionChangedCallback expansionChangedCallback;
  final FavouritePressedCallback favouritePressedCallback;
  final Set<MaterialState> mouseStates;
  final bool favourite;
  final String tokenSymbol;
  final String tokenName;
  final String tokenAmountText;
  final String lowestDenominationText;
  final String fullTokenAmountText;
  final String tokenIcon;

  const BalanceListItemMobile({
    required this.expansionChangedCallback,
    required this.favouritePressedCallback,
    required this.mouseStates,
    required this.favourite,
    required this.tokenSymbol,
    required this.tokenName,
    required this.tokenAmountText,
    required this.lowestDenominationText,
    required this.fullTokenAmountText,
    required this.tokenIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: ExpansionTile(
        collapsedTextColor: DesignColors.gray2_100,
        collapsedIconColor: DesignColors.gray2_100,
        textColor: DesignColors.gray2_100,
        iconColor: DesignColors.gray2_100,
        onExpansionChanged: expansionChangedCallback,
        controlAffinity: ListTileControlAffinity.trailing,
        tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        title: _buildTitleSection(mouseStates),
        children: <Widget>[
          _buildExpansionSection(),
        ],
      ),
    );
  }

  Widget _buildTitleSection(Set<MaterialState> states) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTokenPrefix(states),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            children: <Widget>[
              Text(
                tokenSymbol,
                style: const TextStyle(
                  color: DesignColors.gray2_100,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                tokenAmountText,
                style: const TextStyle(
                  color: DesignColors.white_100,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTokenPrefix(Set<MaterialState> states) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 30,
            child: CircleAvatar(
              backgroundColor: DesignColors.gray1_100,
              radius: 15,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  tokenIcon,
                  errorBuilder: (_, __, ___) {
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(tokenName),
          const SizedBox(width: 10),
          StarButton(
            key: Key(tokenSymbol),
            onChanged: favouritePressedCallback,
            value: favourite,
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionSection() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPrefixedText(
            prefix: 'Faucet',
            value: 'XXX',
          ),
          const SizedBox(height: 12),
          _buildPrefixedText(
            prefix: 'Lowest denomination',
            value: lowestDenominationText,
          ),
          const SizedBox(height: 15),
          _buildPrefixedText(
            prefix: 'Full amount',
            value: fullTokenAmountText,
          ),
          const SizedBox(height: 15),
          KiraOutlinedButton(
            height: 40,
            onPressed: () {},
            title: 'Send',
          ),
        ],
      ),
    );
  }

  Widget _buildPrefixedText({required String prefix, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          prefix,
          style: const TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: DesignColors.white_100,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
