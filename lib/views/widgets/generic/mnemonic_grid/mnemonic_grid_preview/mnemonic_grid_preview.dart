import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/mnemonic_grid_preview/mnemonic_grid_preview_list_item.dart';

const int kColumnsCount = 2;
const double kTextFieldHeight = 30;
const double kItemsGap = 10;

class MnemonicGridPreview extends StatelessWidget {
  final Mnemonic mnemonic;

  const MnemonicGridPreview({
    required this.mnemonic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: kColumnsCount,
        mainAxisSpacing: kItemsGap,
        crossAxisSpacing: kItemsGap,
        mainAxisExtent: kTextFieldHeight,
      ),
      itemCount: mnemonic.array.length,
      itemBuilder: (BuildContext context, int index) {
        return MnemonicGridPreviewListItem(
          index: index + 1,
          word: mnemonic.array[index],
        );
      },
    );
  }
}
