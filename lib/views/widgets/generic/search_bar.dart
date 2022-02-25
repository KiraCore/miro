import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class SearchBar extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor;
  final InputBorder? border;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final ValueChanged<String>? onChanged;

  const SearchBar({
    this.width = double.infinity,
    this.height = double.infinity,
    this.border,
    this.backgroundColor,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: backgroundColor != null,
          hintText: 'Search for anything',
          hintStyle: const TextStyle(
            color: DesignColors.gray2_100,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            AppIcons.search,
            size: 18,
            color: DesignColors.gray2_100,
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
