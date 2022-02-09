import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class KiraTextField extends StatefulWidget {
  final KiraTextFieldController controller;
  final String? hint;
  final String? label;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const KiraTextField({
    required this.controller,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.hint,
    this.label,
    this.suffixIcon,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraTextField();
}

class _KiraTextField extends State<KiraTextField> {
  final FocusNode inputFocusNode = FocusNode();
  String? errorMessage;
  bool obscureTextStatus = false;

  @override
  void initState() {
    obscureTextStatus = widget.obscureText;
    widget.controller.initController(
      validate: _validate,
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
          controller: widget.controller.textController,
          onChanged: widget.onChanged,
          obscureText: obscureTextStatus,
          readOnly: widget.readOnly,
          style: const TextStyle(
            color: DesignColors.white_100,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: DesignColors.gray1_100,
            errorText: errorMessage,
            errorStyle: const TextStyle(
              color: DesignColors.red,
            ),
            suffixIcon: _getSuffixIcon(),
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
      errorMessage = widget.validator!(widget.controller.textController.text);
      setState(() {});
    }
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

  Widget? _getSuffixIcon() {
    Widget? iconWidget;
    if (widget.suffixIcon != null) {
      iconWidget = widget.suffixIcon;
    }
    if (widget.obscureText == true && obscureTextStatus) {
      iconWidget = IconButton(
        onPressed: () => setState(() {
          obscureTextStatus = false;
        }),
        icon: const Icon(
          AppIcons.hidden,
          size: 16,
          color: DesignColors.gray2_100,
        ),
      );
    }
    if (widget.obscureText == true && !obscureTextStatus) {
      iconWidget = IconButton(
        onPressed: () => setState(() {
          obscureTextStatus = true;
        }),
        icon: const Icon(
          AppIcons.visible,
          size: 16,
          color: DesignColors.gray2_100,
        ),
      );
    }
    if (iconWidget != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: iconWidget,
      );
    }
    return null;
  }
}
