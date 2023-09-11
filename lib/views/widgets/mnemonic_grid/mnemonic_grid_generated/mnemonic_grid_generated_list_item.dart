import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class MnemonicGridGeneratedListItem extends StatelessWidget {
  final int index;
  final String word;

  const MnemonicGridGeneratedListItem({
    required this.index,
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 0, right: 3, top: 4, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: textTheme.caption!.copyWith(
                color: DesignColors.greenStatus1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              word,
              maxLines: 1,
              style: textTheme.caption!.copyWith(
                color: DesignColors.white2,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
