import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_list/components/language_dropdown/language_list.dart';

class LanguagePopMenu extends StatelessWidget {
  final PopWrapperController popWrapperController;
  final double width;

  const LanguagePopMenu({
    required this.popWrapperController,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: LanguageList(
        onTap: popWrapperController.hideTooltip,
      ),
    );
  }
}
