import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_list/components/language_dropdown/language_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/language_dropdown/language_pop_menu.dart';

class LanguageDropdown extends StatefulWidget {
  final double height;
  final double width;

  const LanguageDropdown({
    this.height = 60,
    this.width = 120,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PopWrapper(
        popWrapperController: popWrapperController,
        buttonBuilder: LanguageDropdownButton.new,
        popupBuilder: () {
          return LanguagePopMenu(
            popWrapperController: popWrapperController,
            width: widget.width,
          );
        },
      ),
    );
  }
}
