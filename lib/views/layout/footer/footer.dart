import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

const double kFooterHeight = 50;

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColumnRowSwapper(
        columnMainAxisAlignment: MainAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        expandOnRow: true,
        children: <Widget>[
          _buildTextSection(context),
          _buildIconSection(context),
        ],
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return ColumnRowSwapper(
      rowCrossAxisAlignment: CrossAxisAlignment.center,
      rowMainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildTextButton(
          text: 'User terms',
          onPressed: () {},
        ),
        const SizedBox(width: 32),
        _buildTextButton(
          text: 'Privacy Policy',
          onPressed: () {},
        ),
        const SizedBox(width: 32),
        _buildTextButton(
          text: 'White Paper',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTextButton({required VoidCallback onPressed, required String text}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Row(
      mainAxisAlignment: ResponsiveWidget.isLargeScreen(context) ? MainAxisAlignment.end : MainAxisAlignment.center,
      children: <Widget>[
        _buildIconButton(
          icon: const Icon(AppIcons.twitter),
          onPressed: () {},
        ),
        _buildIconButton(
          icon: const Icon(AppIcons.medium),
          onPressed: () {},
        ),
        _buildIconButton(
          icon: const Icon(AppIcons.github),
          onPressed: () {},
        ),
        _buildIconButton(
          icon: const Icon(AppIcons.telegram),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildIconButton({required VoidCallback onPressed, required Icon icon}) {
    return IconButton(
      onPressed: onPressed,
      color: DesignColors.gray2_100,
      splashRadius: 20,
      icon: icon,
      iconSize: 20,
    );
  }
}
