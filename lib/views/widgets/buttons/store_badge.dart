import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

const double kBadgeWidth = 161;
const double kBadgeHeight = 52;

enum StoreType {
  apple,
  google,
}

class StoreBadge extends StatelessWidget {
  final StoreType storeType;

  const StoreBadge({
    required this.storeType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kBadgeWidth,
      height: kBadgeHeight,
      child: MouseStateListener(
        onTap: () {},
        childBuilder: (Set<MaterialState> states) {
          return Opacity(
            opacity: states.contains(MaterialState.disabled) ? 0.3 : 1,
            child: Container(
              width: kBadgeWidth,
              height: kBadgeHeight,
              decoration: BoxDecoration(
                color: _getBackgroundColor(states),
                border: Border.all(
                  color: _getBorderColor(states),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 11),
                child: Image.asset(
                  storeType == StoreType.apple ? Assets.badgesAppStore : Assets.badgesGooglePlay,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return DesignColors.blue2_100;
    }
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.blue1_100;
    }
    return Colors.transparent;
  }

  Color _getBorderColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return DesignColors.blue2_100;
    }
    return DesignColors.blue1_100;
  }
}
