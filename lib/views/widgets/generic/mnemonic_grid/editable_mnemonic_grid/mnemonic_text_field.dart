import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_hint_text.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_layout.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_listeners.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_selection_controls.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/mnemonic_grid_item_prefix.dart';

class MnemonicTextField extends StatefulWidget {
  final EditableMnemonicGridController editableMnemonicGridController;
  final MnemonicTextFieldController mnemonicTextFieldController;

  const MnemonicTextField({
    required this.editableMnemonicGridController,
    required this.mnemonicTextFieldController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicTextField();
}

class _MnemonicTextField extends State<MnemonicTextField> {
  final TextStyle textStyle = const TextStyle(
    fontSize: 14,
    height: 1,
    letterSpacing: 3,
    color: DesignColors.white_100,
  );

  @override
  void initState() {
    super.initState();
    widget.mnemonicTextFieldController.focusNode.addListener(widget.mnemonicTextFieldController.handleFocusChanged);
  }

  @override
  void dispose() {
    widget.mnemonicTextFieldController.focusNode.removeListener(widget.mnemonicTextFieldController.handleFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MnemonicGridItemListeners(
      editableMnemonicGridController: widget.editableMnemonicGridController,
      mnemonicTextFieldController: widget.mnemonicTextFieldController,
      child: MnemonicTextFieldLayout(
        mnemonicTextFieldController: widget.mnemonicTextFieldController,
        prefixWidget: Center(
          child: ValueListenableBuilder<bool?>(
            valueListenable: widget.mnemonicTextFieldController.validNotifier,
            builder: (_, bool? isValid, __) => _buildMnemonicGridItemPrefix(isValid),
          ),
        ),
        hintWidget: ValueListenableBuilder<bool>(
          valueListenable: widget.mnemonicTextFieldController.showPlaceholderNotifier,
          builder: (_, bool showPlaceholder, __) => _buildHintWidget(showPlaceholder),
        ),
        editableWidget: EditableText(
          controller: widget.mnemonicTextFieldController.textEditingController,
          selectionControls: MnemonicTextSelectionControls(
            index: widget.mnemonicTextFieldController.index,
            editableMnemonicGridController: widget.editableMnemonicGridController,
          ),
          focusNode: widget.mnemonicTextFieldController.focusNode,
          cursorColor: DesignColors.gray2_100,
          backgroundCursorColor: DesignColors.green_100,
          onChanged: (_) => _onChanged(),
          onSubmitted: widget.mnemonicTextFieldController.handleTextFieldSubmitted,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            LengthLimitingTextInputFormatter(8),
          ],
          style: textStyle,
        ),
      ),
    );
  }

  Widget _buildMnemonicGridItemPrefix(bool? isValid) {
    return MnemonicGridItemPrefix(
      index: widget.mnemonicTextFieldController.index + 1,
      valid: isValid,
    );
  }

  Widget _buildHintWidget(bool showPlaceholder) {
    final String typedText = widget.mnemonicTextFieldController.textEditingController.text;
    if (typedText.isEmpty) {
      return Text('--------', style: textStyle);
    }
    return ValueListenableBuilder<String>(
      valueListenable: widget.mnemonicTextFieldController.hintNotifier,
      builder: (_, String hint, __) {
        return MnemonicTextFieldHintText(
          typedText: typedText,
          hintText: hint,
          textStyle: textStyle.copyWith(color: DesignColors.gray2_100),
        );
      },
    );
  }

  void _onChanged() {
    String value = widget.mnemonicTextFieldController.textEditingController.text;
    widget.mnemonicTextFieldController.handleTextFieldChanged(value);
  }
}
