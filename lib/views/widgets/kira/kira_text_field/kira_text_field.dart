import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class KiraTextField extends StatefulWidget {
  final KiraTextFieldController controller;
  final String? hint;
  final String? label;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const KiraTextField({
    required this.controller,
    this.hint,
    this.label,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraTextField();
}

class _KiraTextField extends State<KiraTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.obscureTextNotifier.value = widget.obscureText;
    widget.controller.validateReloadNotifierModel.addListener(_handleValidateTextField);
  }

  @override
  void dispose() {
    widget.controller.validateReloadNotifierModel.removeListener(_handleValidateTextField);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: DesignColors.grey3,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text(
            widget.label!,
            style: textTheme.bodyText2!.copyWith(
              color: _getLabelColor(),
            ),
          ),
          const SizedBox(height: 8),
        ],
        AnimatedBuilder(
          animation: Listenable.merge(<Listenable>[
            widget.controller.obscureTextNotifier,
            widget.controller.errorNotifier,
          ]),
          builder: (BuildContext context, _) {
            return TextField(
              focusNode: widget.controller.focusNode,
              controller: widget.controller.textEditingController,
              onChanged: widget.onChanged,
              obscureText: widget.controller.obscureTextNotifier.value,
              readOnly: widget.readOnly,
              inputFormatters: widget.inputFormatters,
              style: textTheme.bodyText1!.copyWith(
                color: DesignColors.white1,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: DesignColors.black,
                hoverColor: DesignColors.greyHover2,
                errorText: widget.controller.errorNotifier.value,
                errorStyle: textTheme.caption!.copyWith(
                  color: DesignColors.redStatus1,
                ),
                suffixIcon: _getSuffixIcon(),
                errorMaxLines: 1,
                hintText: widget.hint,
                hintStyle: textTheme.bodyText1!.copyWith(
                  color: DesignColors.grey1,
                ),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder.copyWith(
                  borderSide: outlineInputBorder.borderSide.copyWith(color: DesignColors.greyOutline),
                ),
                focusedBorder: outlineInputBorder.copyWith(
                  borderSide: outlineInputBorder.borderSide.copyWith(color: DesignColors.white1),
                ),
                errorBorder: outlineInputBorder.copyWith(
                  borderSide: outlineInputBorder.borderSide.copyWith(color: DesignColors.redStatus1),
                ),
                focusedErrorBorder: outlineInputBorder.copyWith(
                  borderSide: outlineInputBorder.borderSide.copyWith(color: DesignColors.redStatus1),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _handleValidateTextField() {
    if (widget.validator == null) {
      widget.controller.errorNotifier.value = null;
    } else {
      widget.controller.errorNotifier.value = widget.validator!(widget.controller.textEditingController.text);
    }
  }

  Color _getLabelColor() {
    if (widget.controller.errorNotifier.value != null) {
      return DesignColors.redStatus1;
    }
    if (widget.controller.focusNode.hasFocus) {
      return DesignColors.white1;
    }
    return DesignColors.white2;
  }

  Widget? _getSuffixIcon() {
    Widget? iconWidget;
    if (widget.suffixIcon != null) {
      iconWidget = widget.suffixIcon;
    }
    if (widget.obscureText == true && widget.controller.obscureTextNotifier.value == true) {
      iconWidget = IconButton(
        onPressed: () => widget.controller.obscureTextNotifier.value = false,
        icon: const Icon(
          AppIcons.eye_hidden,
          size: 16,
          color: DesignColors.accent,
        ),
      );
    }
    if (widget.obscureText == true && widget.controller.obscureTextNotifier.value == false) {
      iconWidget = IconButton(
        onPressed: () => widget.controller.obscureTextNotifier.value = true,
        icon: const Icon(
          AppIcons.eye_visible,
          size: 16,
          color: DesignColors.accent,
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
