import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextStyle textStyle;
  final bool enabled;
  final double height;
  final double width;
  final String? label;
  final Color? backgroundColor;
  final VoidCallback? onClear;
  final ValueChanged<String>? onSubmit;
  final InputBorder? border;

  const SearchBar({
    required this.textEditingController,
    required this.textStyle,
    this.enabled = true,
    this.height = double.infinity,
    this.width = double.infinity,
    this.label,
    this.backgroundColor,
    this.onClear,
    this.onSubmit,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  late final ValueNotifier<bool> clearButtonVisibleNotifier = ValueNotifier<bool>(widget.textEditingController.text.isNotEmpty);

  @override
  void dispose() {
    clearButtonVisibleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchBarWidget = SizedBox(
      width: widget.width,
      height: widget.height,
      child: ValueListenableBuilder<bool>(
        valueListenable: clearButtonVisibleNotifier,
        builder: (BuildContext context, bool clearButtonVisible, _) {
          return TextFormField(
            enabled: widget.enabled,
            controller: widget.textEditingController,
            onFieldSubmitted: (_) => _submitSearchBar(),
            onChanged: _handleSearchBarChanged,
            style: widget.textStyle,
            decoration: InputDecoration(
              hoverColor: DesignColors.greyHover1,
              fillColor: widget.backgroundColor,
              filled: widget.backgroundColor != null,
              hintText: widget.label,
              hintStyle: widget.textStyle.copyWith(color: DesignColors.grey1),
              prefixIcon: IconButton(
                icon: const Icon(
                  AppIcons.search,
                  color: DesignColors.grey1,
                  size: 18,
                ),
                onPressed: _submitSearchBar,
              ),
              suffixIcon: clearButtonVisible
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          icon: const Icon(
                            AppIcons.cancel,
                            color: DesignColors.accent,
                            size: 18,
                          ),
                          onPressed: _pressClearButton),
                    )
                  : null,
              border: widget.border,
              disabledBorder: widget.border,
              enabledBorder: widget.border,
              errorBorder: widget.border,
              focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: DesignColors.white1), borderRadius: BorderRadius.circular(8)),
              focusedErrorBorder: widget.border,
            ),
          );
        },
      ),
    );

    if (widget.enabled == false) {
      searchBarWidget = Opacity(
        opacity: 0.4,
        child: IgnorePointer(child: searchBarWidget),
      );
    }

    return searchBarWidget;
  }

  void _handleSearchBarChanged(String value) {
    clearButtonVisibleNotifier.value = value.isNotEmpty;

    if (value.isEmpty) {
      widget.onClear?.call();
    }
  }

  void _submitSearchBar() {
    widget.onSubmit?.call(widget.textEditingController.text);
  }

  void _pressClearButton() {
    widget.textEditingController.clear();
    clearButtonVisibleNotifier.value = false;
    widget.onClear?.call();
  }
}
