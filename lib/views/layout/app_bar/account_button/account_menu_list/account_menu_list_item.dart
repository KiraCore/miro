import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class AccountMenuListItem extends StatelessWidget {
  final VoidCallback onTap;
  final Text title;

  const AccountMenuListItem({
    required this.onTap,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title.data!,
            style: TextStyle(
              fontSize: 14,
              color: states.contains(MaterialState.hovered)
                  ? DesignColors.white_100
                  : title.style?.color ?? DesignColors.gray2_100,
            ),
          ),
        );
      },
    );
  }
}
