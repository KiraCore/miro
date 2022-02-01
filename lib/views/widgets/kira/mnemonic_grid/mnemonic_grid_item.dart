// ignore: implementation_imports
import 'package:bip39/src/wordlists/english.dart' as bip39;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';

enum MnemonicState {
  valid,
  invalid,
  waiting,
}

class MnemonicGridItem extends StatefulWidget {
  final TextEditingController textController;
  final int index;
  final String? mnemonicWord;

  const MnemonicGridItem({
    required this.textController,
    required this.index,
    this.mnemonicWord,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicGridItem();
}

class _MnemonicGridItem extends State<MnemonicGridItem> {
  MnemonicState mnemonicState = MnemonicState.waiting;

  @override
  void initState() {
    widget.textController.addListener(() {
      _validateMnemonic(widget.textController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 12,
        color: DesignColors.gray3_100,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(8),
      ],
      onChanged: _validateMnemonic,
      validator: (String? text) {
        _validateMnemonic(text);
        return null;
      },
      decoration: InputDecoration(
        errorText: null,
        errorMaxLines: null,
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        prefixIcon: SizedBox(
          width: 20,
          child: Center(
            child: Text(
              '${widget.index + 1}',
              style: const TextStyle(
                fontSize: 12,
                color: DesignColors.gray2_100,
              ),
            ),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _getBorderColor(),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: DesignColors.blue1_100,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _validateMnemonic(String? text) {
    bool validWord = bip39.WORDLIST.contains(text);
    MnemonicState newState = MnemonicState.waiting;
    if (validWord) {
      newState = MnemonicState.valid;
    } else {
      newState = MnemonicState.invalid;
    }
    if (newState != mnemonicState) {
      setState(() {
        mnemonicState = newState;
      });
    }
  }

  Color _getBorderColor() {
    if (mnemonicState == MnemonicState.invalid) {
      return DesignColors.red;
    }
    if (mnemonicState == MnemonicState.valid) {
      return DesignColors.green;
    }
    return DesignColors.gray2_100;
  }
}
