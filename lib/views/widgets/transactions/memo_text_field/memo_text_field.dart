import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_length_text_input_formatter.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

// TODO(dominik): Rename to RestrictedTextfield
class MemoTextField extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController memoTextEditingController;
  final int maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const MemoTextField({
    required this.label,
    required this.onChanged,
    required this.memoTextEditingController,
    this.maxLength = 256,
    this.maxLines,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoTextField();
}

class _MemoTextField extends State<MemoTextField> {
  final ValueNotifier<int> replacedMemoLengthNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _listenMemoTextFieldChange(widget.memoTextEditingController.text);
  }

  @override
  void dispose() {
    replacedMemoLengthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxInputWrapper(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 20),
      child: Column(
        children: <Widget>[
          TxTextField(
            textEditingController: widget.memoTextEditingController,
            label: widget.label,
            maxLines: widget.maxLines,
            onChanged: _listenMemoTextFieldChange,
            inputFormatters: <TextInputFormatter>[
              ...widget.inputFormatters ?? <TextInputFormatter>[FilteringTextInputFormatter.allow(StringUtils.basicCharactersRegExp)],
              MemoLengthTextInputFormatter(widget.maxLength),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ValueListenableBuilder<int>(
                valueListenable: replacedMemoLengthNotifier,
                builder: (BuildContext context, int replacedMemoLength, _) {
                  return Text(
                    '${replacedMemoLength} / ${widget.maxLength}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9B9B9B),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _listenMemoTextFieldChange(String memo) {
    String replacedMemo = TxUtils.replaceMemoRestrictedChars(memo);
    replacedMemoLengthNotifier.value = replacedMemo.length;
    widget.onChanged.call(memo);
  }
}
