import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/mnemonic_grid_item.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/model/mnemonic_grid_controller.dart';

class MnemonicGrid extends StatefulWidget {
  final MnemonicGridController controller;
  final List<String> mnemonicWordList;
  final int mnemonicSize;
  final int columnsCount;
  final bool editable;

  const MnemonicGrid({
    required this.controller,
    required this.editable,
    this.mnemonicWordList = const <String>[],
    this.mnemonicSize = 24,
    this.columnsCount = 2,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicGrid();
}

class _MnemonicGrid extends State<MnemonicGrid> {
  List<TextEditingController> mnemonicControllers = List<TextEditingController>.empty(growable: true);

  @override
  void initState() {
    _initController();
    _initMnemonicTextControllers();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MnemonicGrid oldWidget) {
    if (oldWidget.mnemonicWordList != widget.mnemonicWordList) {
      _initMnemonicTextControllers();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      shortcuts: <ShortcutActivator, Intent>{
        pasteKeySetWindows: PasteIntent(),
      },
      actions: <Type, Action<Intent>>{
        PasteIntent: CallbackAction<PasteIntent>(
          onInvoke: (PasteIntent _) => _handlePasteShortcut(),
        )
      },
      autofocus: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 5.5,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemCount: widget.mnemonicSize,
        itemBuilder: (BuildContext context, int index) {
          return _buildCell(index);
        },
      ),
    );
  }

  void _initController() {
    widget.controller.initController(
      paste: _handlePasteShortcut,
      clear: _clearGrid,
      getValues: _getGridValues,
    );
  }

  Future<void> _handlePasteShortcut() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    List<String> mnemonics = (data?.text ?? '').split(' ');
    for (int i = 0; i < mnemonics.length; i++) {
      if (mnemonics[i].length <= 8) {
        mnemonicControllers[i].text = mnemonics[i];
      }
    }
  }

  void _clearGrid() {
    for (int i = 0; i < widget.mnemonicSize; i++) {
      mnemonicControllers[i].text = '';
    }
  }

  List<String> _getGridValues() {
    List<String> gridValues = List<String>.empty(growable: true);
    for (int i = 0; i < widget.mnemonicSize; i++) {
      TextEditingController textController = mnemonicControllers[i];
      if (textController.text.isNotEmpty) {
        gridValues.add(mnemonicControllers[i].text.toLowerCase());
      }
    }
    return gridValues;
  }

  void _initMnemonicTextControllers() {
    mnemonicControllers.clear();
    for (int i = 0; i < widget.mnemonicSize; i++) {
      String mnemonicWord = widget.mnemonicWordList.length > i ? widget.mnemonicWordList[i] : '';
      mnemonicControllers.add(TextEditingController(text: mnemonicWord));
    }
  }

  Widget _buildCell(int index) {
    String mnemonicWord = widget.mnemonicWordList.length > index ? widget.mnemonicWordList[index] : '';
    TextEditingController textEditingController =
        mnemonicControllers.length > index ? mnemonicControllers[index] : TextEditingController();

    return MnemonicGridItem(
      index: index,
      editable: widget.editable,
      mnemonicWord: mnemonicWord,
      textController: textEditingController,
    );
  }
}
