import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';

class TokenDropdownButton extends StatelessWidget {
  final TokenType? tokenType;

  const TokenDropdownButton({
    this.tokenType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              iconUrl: tokenType?.icon,
            ),
            const SizedBox(width: 6),
            Text(
              tokenType?.name ?? '---',
              style: const TextStyle(color: DesignColors.white_100),
            ),
          ],
        ),
      ],
    );
  }
}
