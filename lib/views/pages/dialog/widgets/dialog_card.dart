import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';

class DialogCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final double width;
  final double? height;
  final double trailingWidth;
  final double trailingHeight;

  const DialogCard({
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.height,
    this.width = 612,
    this.trailingWidth = 30,
    this.trailingHeight = 30,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - AppSizes.defaultDesktopPageMargin.horizontal,
        maxHeight: MediaQuery.of(context).size.height - 100,
        minHeight: 300,
      ),
      decoration: BoxDecoration(
        color: DesignColors.blue1_10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        if (title != null)
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              title!,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        if (subtitle != null) ...<Widget>[
                          if (title != null) const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              subtitle!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: DesignColors.gray2_100,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null)
                    SizedBox(
                      width: trailingWidth,
                      height: trailingHeight,
                      child: trailing!,
                    ),
                ],
              ),
              if (title != null || subtitle != null || trailing != null) const SizedBox(height: 30),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
