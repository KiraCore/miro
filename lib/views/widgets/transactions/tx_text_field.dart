import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController textEditingController;
  final int? maxLines;
  final String? hintText;
  final String? label;
  final bool disabled;
  final bool hasErrors;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const TxTextField({
    required this.onChanged,
    required this.textEditingController,
    this.maxLines,
    this.hintText,
    this.label,
    this.disabled = false,
    this.hasErrors = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
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
      maxLines: widget.maxLines,
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
