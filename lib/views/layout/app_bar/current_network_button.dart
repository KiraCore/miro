import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/connection_drawer_page.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:provider/provider.dart';

class CurrentNetworkButton extends StatelessWidget {
  const CurrentNetworkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: MouseStateListener(
        onTap: () => _openDrawerNetworkPage(context),
        childBuilder: (Set<MaterialState> states) {
          Color foregroundColor = _getForegroundColor(states);
          return Container(
            width: 192.0,
            height: AppSizes.kAppBarItemsHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: foregroundColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.iconsNetworkStatus,
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Consumer<NetworkProvider>(
                      builder: (_, NetworkProvider networkProvider, Widget? child) {
                        String networkName = 'SELECT NETWORK';
                        if (networkProvider.networkModel != null) {
                          networkName = networkProvider.networkModel!.name;
                        }
                        return Text(
                          networkName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: foregroundColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.more_vert,
                    color: foregroundColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openDrawerNetworkPage(BuildContext context) {
    KiraScaffold.of(context).navigateEndDrawerRoute(const ConnectionDrawerPage());
  }

  Color _getForegroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      return DesignColors.blue1_100;
    }
    return DesignColors.gray2_100;
  }
}
