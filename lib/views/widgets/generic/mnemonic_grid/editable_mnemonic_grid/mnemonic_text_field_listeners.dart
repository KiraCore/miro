import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_accept_word_action.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_accept_word_intent.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_paste_mnemonic_action.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_paste_mnemonic_intent.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu_item.dart';

class MnemonicGridItemListeners extends StatelessWidget {
  final Widget child;
  final EditableMnemonicGridController editableMnemonicGridController;
  final MnemonicTextFieldController mnemonicTextFieldController;

  const MnemonicGridItemListeners({
    required this.child,
    required this.editableMnemonicGridController,
    required this.mnemonicTextFieldController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) => _onPointerDown(context, event),
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.tab): AcceptWordShortcutIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyV): PasteMnemonicShortcutIntent(),
          LogicalKeySet(LogicalKeyboardKey.paste): PasteMnemonicShortcutIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            AcceptWordShortcutIntent: AcceptWordShortcutAction(
              mnemonicTextFieldController: mnemonicTextFieldController,
            ),
            PasteMnemonicShortcutIntent: PasteMnemonicShortcutAction(
              index: mnemonicTextFieldController.index,
              editableMnemonicGridController: editableMnemonicGridController,
            ),
          },
          child: child,
        ),
      ),
    );
  }

  Future<void> _onPointerDown(BuildContext context, PointerDownEvent event) async {
    if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
      await KiraContextMenu.show(
        context: context,
        position: event.position,
        menuItems: <KiraContextMenuItem>[
          KiraContextMenuItem(
            label: 'Paste',
            iconData: Icons.content_paste,
            onTap: _handlePaste,
          ),
        ],
      );
    }
  }

  void _handlePaste() {
    PasteMnemonicShortcutAction(
      index: mnemonicTextFieldController.index,
      editableMnemonicGridController: editableMnemonicGridController,
    ).invoke(PasteMnemonicShortcutIntent());
  }
}
