import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/pages/menu/dashboard_page/widgets/dashboard_grid_title_shimmer.dart';

class DashboardGridTile extends StatelessWidget {
  final String? title;
  final String subtitle;
  final Icon? icon;
  final bool loading;
  final String? titleSuffix;

  const DashboardGridTile({
    required this.title,
    required this.subtitle,
    required this.loading,
    this.titleSuffix,
    Key? key,
  })  : icon = null,
        super(key: key);

  const DashboardGridTile.icon({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.loading,
    this.titleSuffix,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 125),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: icon!.color?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: icon,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DashboardGridTileShimmer(
                  enabled: loading,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: title ?? '---',
                      style: textTheme.headline4!.copyWith(
                        color: DesignColors.white2,
                      ),
                      children: <InlineSpan>[
                        if (titleSuffix != null) ...<InlineSpan>[
                          TextSpan(
                            text: '/',
                            style: textTheme.headline4!.copyWith(
                              color: DesignColors.white2,
                            ),
                          ),
                          TextSpan(
                            text: titleSuffix,
                            style: textTheme.headline4!.copyWith(
                              color: DesignColors.accent,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    subtitle.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle2!.copyWith(
                      color: DesignColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
