import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field.dart';

const int kDefaultMnemonicSize = 24;
const int kColumnsCount = 2;
const double kTextFieldHeight = 30;
const double kItemsGap = 10;

class EditableMnemonicGrid extends StatefulWidget {
  final EditableMnemonicGridController editableMnemonicGridController;
  final bool editable;
  final Mnemonic? initialMnemonic;

  EditableMnemonicGrid({
    EditableMnemonicGridController? editableMnemonicGridController,
    this.editable = true,
    this.initialMnemonic,
    Key? key,
  })  : editableMnemonicGridController =
            editableMnemonicGridController ?? EditableMnemonicGridController(mnemonicSize: kDefaultMnemonicSize),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _EditableMnemonicGrid();
}

class _EditableMnemonicGrid extends State<EditableMnemonicGrid> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: gridHeight,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: kColumnsCount,
          mainAxisSpacing: kItemsGap,
          crossAxisSpacing: kItemsGap,
          mainAxisExtent: kTextFieldHeight,
        ),
        itemCount: widget.editableMnemonicGridController.mnemonicTextFieldControllers.length,
        itemBuilder: (BuildContext context, int index) {
          return MnemonicTextField(
            editableMnemonicGridController: widget.editableMnemonicGridController,
            mnemonicTextFieldController: widget.editableMnemonicGridController.mnemonicTextFieldControllers[index],
          );
        },
      ),
    );
  }

  double get gridHeight {
    double rowsCount = widget.editableMnemonicGridController.mnemonicSize / kColumnsCount;
    double textFieldsSize = rowsCount * kTextFieldHeight;
    double paddingSize = rowsCount * kItemsGap;
    return textFieldsSize + paddingSize;
  }
}
