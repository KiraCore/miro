import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';

typedef FavouritePressedCallback = void Function(bool value);

class BalanceTokenPrefix extends StatelessWidget {
  final TokenAliasModel tokenAliasModel;
  final bool favourite;
  final bool favouriteAlwaysVisible;
  final ValueNotifier<bool> hoverNotifier;
  final FavouritePressedCallback favouritePressedCallback;
  final double height;

  const BalanceTokenPrefix({
    required this.tokenAliasModel,
    required this.favourite,
    required this.favouriteAlwaysVisible,
    required this.hoverNotifier,
    required this.favouritePressedCallback,
    this.height = 30,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget favouriteButton = StarButton(
      key: Key('fav_${tokenAliasModel.name}'),
      onChanged: favouritePressedCallback,
      value: favourite,
    );

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TokenAvatar(
            iconUrl: tokenAliasModel.icon,
            size: height,
          ),
          const SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 150,
            ),
            child: Text(
              tokenAliasModel.name,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText1!.copyWith(
                color: DesignColors.gray2_100,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (favouriteAlwaysVisible)
            favouriteButton
          else ...<Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: hoverNotifier,
              builder: (_, bool hovered, __) {
                if (_isFavouriteButtonVisible(hovered: hovered)) {
                  return favouriteButton;
                }
                return const SizedBox();
              },
            ),
          ],
        ],
      ),
    );
  }

  bool _isFavouriteButtonVisible({required bool hovered}) {
    if (favouriteAlwaysVisible) {
      return true;
    } else if (hovered || favourite) {
      return true;
    }
    return false;
  }
}
