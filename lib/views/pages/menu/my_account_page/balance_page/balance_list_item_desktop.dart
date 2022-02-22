import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';

class BalanceListItemDesktop extends StatelessWidget {
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

  const BalanceListItemDesktop({
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
        controlAffinity: ListTileControlAffinity.leading,
        tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        title: _buildTitleSection(mouseStates),
        children: <Widget>[
          _buildExpansionSection(),
        ],
      ),
    );
  }

  Widget _buildTitleSection(Set<MaterialState> states) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: _buildTokenPrefix(states),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            tokenSymbol,
            style: const TextStyle(
              color: DesignColors.gray2_100,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            tokenAmountText,
            style: const TextStyle(
              color: DesignColors.white_100,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 15),
        const Spacer(),
        SizedBox(
          width: 70,
          child: KiraOutlinedButton(
            height: 40,
            onPressed: () {},
            title: 'Send',
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
          if (favourite || states.contains(MaterialState.hovered)) ...<Widget>[
            const SizedBox(width: 10),
            StarButton(
              key: Key(tokenSymbol),
              onChanged: favouritePressedCallback,
              value: favourite,
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildExpansionSection() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 78,
        right: 25,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Token icon space
          Expanded(
            child: Row(
              children: <Widget>[
                const SizedBox(width: 40),
                Expanded(
                  child: _buildPrefixedText(
                    prefix: 'Faucet',
                    value: 'XXX',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildPrefixedText(
              prefix: 'Lowest denomination',
              value: lowestDenominationText,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildPrefixedText(
              prefix: 'Full amount',
              value: fullTokenAmountText,
            ),
          ),
          const SizedBox(width: 15),
          const Spacer(),
          const SizedBox(
            width: 70,
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
