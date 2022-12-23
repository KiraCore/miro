import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

class KiraScaffoldSearchBar extends StatelessWidget {
  final bool enabled;
  
  const KiraScaffoldSearchBar({
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    );

    return SearchBar(
      label: 'Search for anything',
      height: 50,
      enabled: enabled,
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: DesignColors.white_100,
      ),
    );
  }
}
