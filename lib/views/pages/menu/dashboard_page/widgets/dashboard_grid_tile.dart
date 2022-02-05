import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class DashboardGridTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon? icon;

  const DashboardGridTile({
    required this.title,
    required this.subtitle,
    Key? key,
  })  : icon = null,
        super(key: key);

  const DashboardGridTile.icon({
    required this.title,
    required this.subtitle,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            _buildIcon(),
            const SizedBox(
              width: 16,
            ),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: DesignColors.white_100,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: DesignColors.gray2_100,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: icon!.color?.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
