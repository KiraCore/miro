import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class SearchBar extends StatelessWidget {
  final TextStyle textStyle;
  final String? label;
  final double width;
  final double height;
  final Color? backgroundColor;
  final InputBorder? border;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final ValueChanged<String>? onFieldSubmitted;

  const SearchBar({
    required this.textStyle,
    this.label,
    this.width = double.infinity,
    this.height = double.infinity,
    this.border,
    this.backgroundColor,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        style: textStyle,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          hintText: label,
          hintStyle: textStyle.copyWith(
            color: DesignColors.gray2_100,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Icon(
              AppIcons.search,
              size: 18,
              color: DesignColors.gray2_100,
            ),
          ),
          border: border,
          disabledBorder: disabledBorder,
          enabledBorder: enabledBorder,
          errorBorder: errorBorder,
          focusedBorder: focusedBorder,
          focusedErrorBorder: focusedErrorBorder,
        ),
      ),
    );
  }
}
