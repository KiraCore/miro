import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';

class AccountPopMenu extends StatefulWidget {
  final double width;
  final PopWrapperController popWrapperController;

  const AccountPopMenu({
    required this.width,
    required this.popWrapperController,
    Key? key,
  }) : super(key: key);

  @override
  State<AccountPopMenu> createState() => _AccountPopMenuState();
}

class _AccountPopMenuState extends State<AccountPopMenu> {
  // @override
  // void dispose() {
  //   widget.popWrapperController.hideTooltip();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AccountMenuList(onItemTap: _onTap),
    );
  }

  void _onTap() {
    widget.popWrapperController.hideTooltip();
  }
}
