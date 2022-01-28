import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_desktop_decoration.dart';

class KiraAppBarDesktop extends StatelessWidget {
  final AppBarDesktopDecoration desktopDecoration;

  const KiraAppBarDesktop({
    required this.desktopDecoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.kKiraAppBarHeight - 1,
      decoration: BoxDecoration(
        color: desktopDecoration.backgroundColor,
        border: desktopDecoration.border,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildAppBarContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 13,
        right: 41,
        left: 32,
      ),
      child: desktopDecoration.sidebar,
    );
  }
}
