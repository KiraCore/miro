import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TxTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController textEditingController;
  final int? maxLength;
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
    this.maxLength,
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
    TextStyle? textStyle = ResponsiveWidget.isLargeScreen(context) ? textTheme.bodyLarge : textTheme.bodyMedium;

    return TextFormField(
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      enabled: !widget.disabled,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      style: textStyle?.copyWith(
        color: widget.hasErrors ? DesignColors.redStatus1 : DesignColors.white1,
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        label: widget.label != null ? Text(widget.label!) : null,
        labelStyle: textStyle?.copyWith(
          color: DesignColors.accent,
          height: 0.5,
        ),
        hintText: widget.hintText,
        hintStyle: textStyle?.copyWith(
          color: widget.hasErrors ? DesignColors.redStatus1 : DesignColors.white1,
        ),
        errorStyle: textTheme.bodySmall!.copyWith(
          color: DesignColors.redStatus1,
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
