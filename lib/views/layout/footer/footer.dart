import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/views/layout/footer/footer_icon_button.dart';
import 'package:miro/views/layout/footer/footer_text_button.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: ColumnRowSwapper(
        columnMainAxisAlignment: MainAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        expandOnRow: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: ResponsiveWidget.isLargeScreen(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: <Widget>[
              FooterTextButton(
                title: 'User terms',
                onPressed: () {},
              ),
              const SizedBox(width: 32),
              FooterTextButton(
                title: 'Privacy Policy',
                onPressed: () {},
              ),
              const SizedBox(width: 32),
              FooterTextButton(
                title: 'White Paper',
                onPressed: () {},
              ),
            ],
          ),
          const ColumnRowSpacer(size: 25),
          Row(
            mainAxisAlignment: ResponsiveWidget.isLargeScreen(context) ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: <Widget>[
              FooterIconButton(
                iconData: AppIcons.twitter,
                onPressed: () {},
              ),
              FooterIconButton(
                iconData: AppIcons.medium,
                onPressed: () {},
              ),
              FooterIconButton(
                iconData: AppIcons.github,
                onPressed: () {},
              ),
              FooterIconButton(
                iconData: AppIcons.telegram,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
