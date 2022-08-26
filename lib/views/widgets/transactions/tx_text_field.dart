import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController textEditingController;

  final bool disabled;
  final FocusNode? focusNode;
  final bool hasErrors;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? label;
  final FormFieldValidator<String>? validator;

  const TxTextField({
    required this.onChanged,
    required this.textEditingController,
    this.disabled = false,
    this.focusNode,
    this.hasErrors = false,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.label,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxTextField();
}

class _TxTextField extends State<TxTextField> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      enabled: !widget.disabled,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      style: textTheme.bodyText1!.copyWith(
        color: widget.hasErrors ? DesignColors.red_100 : DesignColors.white_100,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        label: widget.label != null ? Text(widget.label!) : null,
        labelStyle: textTheme.bodyText1!.copyWith(
          color: DesignColors.gray2_100,
          height: 0.5,
        ),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyText1!.copyWith(
          color: widget.hasErrors ? DesignColors.red_100 : DesignColors.white_100,
        ),
        errorStyle: textTheme.caption!.copyWith(
          color: DesignColors.red_100,
        ),
        isDense: true,
        floatingLabelBehavior: widget.hintText != null ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
