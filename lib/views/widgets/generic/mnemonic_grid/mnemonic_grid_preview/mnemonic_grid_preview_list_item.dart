import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/mnemonic_grid_item_prefix.dart';

const double kLeadingWidth = 20;

class MnemonicGridPreviewListItem extends StatelessWidget {
  final int index;
  final String word;
  final double leadingWidth;

  const MnemonicGridPreviewListItem({
    required this.index,
    required this.word,
    this.leadingWidth = kLeadingWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: leadingWidth,
            child: MnemonicGridItemPrefix(index: index),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              word,
              style: const TextStyle(
                fontSize: 14,
                height: 1,
                letterSpacing: 3,
                color: DesignColors.white_100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
