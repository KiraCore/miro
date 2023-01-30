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
  final ValueNotifier<bool> clearButtonVisibleNotifier = ValueNotifier<bool>(false);

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
            onFieldSubmitted: (_) => _onSubmitSearchBar(),
            onChanged: _onChangedSearchBar,
            style: widget.textStyle,
            decoration: InputDecoration(
              fillColor: widget.backgroundColor,
              filled: widget.backgroundColor != null,
              hintText: widget.label,
              hintStyle: widget.textStyle.copyWith(color: DesignColors.gray2_100),
              prefixIcon: IconButton(
                icon: const Icon(
                  AppIcons.search,
                  color: DesignColors.gray2_100,
                  size: 18,
                ),
                onPressed: _onSubmitSearchBar,
              ),
              suffixIcon: clearButtonVisible
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          icon: const Icon(
                            AppIcons.cancel,
                            color: DesignColors.white_100,
                            size: 18,
                          ),
                          onPressed: _pressClearButton),
                    )
                  : null,
              border: widget.border,
              disabledBorder: widget.border,
              enabledBorder: widget.border,
              errorBorder: widget.border,
              focusedBorder: widget.border,
              focusedErrorBorder: widget.border,
            ),
          );
        },
      ),
    );

    if (widget.enabled == false) {
      searchBarWidget = Opacity(
        opacity: 0.4,
        child: IgnorePointer(
          child: searchBarWidget,
        ),
      );
    }

    return searchBarWidget;
  }

  void _onChangedSearchBar(String value) {
    clearButtonVisibleNotifier.value = value.isNotEmpty;

    if (value.isEmpty) {
      widget.onClear?.call();
    }
  }

  void _onSubmitSearchBar() {
    widget.onSubmit?.call(widget.textEditingController.text);
  }

  void _pressClearButton() {
    widget.textEditingController.clear();
    clearButtonVisibleNotifier.value = false;
    widget.onClear?.call();
  }
}
