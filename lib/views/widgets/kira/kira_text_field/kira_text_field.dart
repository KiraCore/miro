import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class KiraTextField extends StatefulWidget {
  final KiraTextFieldController controller;
  final String? hint;
  final String? label;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const KiraTextField({
    required this.controller,
    this.validator,
    this.hint,
    this.label,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraTextField();
}

class _KiraTextField extends State<KiraTextField> {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode inputFocusNode = FocusNode();
  String? errorMessage;

  @override
  void initState() {
    widget.controller.initController(
      validate: _validate,
      textController: textEditingController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              color: _getLabelColor(),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          focusNode: inputFocusNode,
          controller: textEditingController,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: DesignColors.gray1_100,
            errorText: errorMessage,
            errorStyle: const TextStyle(
              color: DesignColors.red,
            ),
            errorMaxLines: 1,
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: DesignColors.gray2_100,
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: DesignColors.blue1_100,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: DesignColors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: DesignColors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  String? _validate() {
    if (widget.validator == null) {
      errorMessage = null;
    } else {
      errorMessage = widget.validator!(textEditingController.text);
    }
    setState(() {});
    return errorMessage;
  }

  Color _getLabelColor() {
    if (errorMessage != null) {
      return DesignColors.red;
    }
    if (inputFocusNode.hasFocus) {
      return DesignColors.blue1_100;
    }
    return DesignColors.gray2_100;
  }
}
