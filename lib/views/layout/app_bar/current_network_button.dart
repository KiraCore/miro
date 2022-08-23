import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/network_drawer_page/network_drawer_page.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/network_status_icon.dart';

class CurrentNetworkButton extends StatelessWidget {
  final double width;

  const CurrentNetworkButton({
    this.width = 192,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      builder: (_, NetworkModuleState networkModuleState) {
        ANetworkStatusModel networkStatusModel = networkModuleState.networkStatusModel;

        return MouseStateListener(
          onTap: () => _openDrawerNetworkPage(context),
          disableSplash: true,
          childBuilder: (Set<MaterialState> states) {
            Color foregroundColor = _selectForegroundColor(states);

            return Container(
              width: width,
              height: AppSizes.kAppBarItemsHeight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: foregroundColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NetworkStatusIcon(networkStatusModel: networkStatusModel, size: 12),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        networkStatusModel.name,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: foregroundColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
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
        );
      },
    );
  }

  void _openDrawerNetworkPage(BuildContext context) {
    KiraScaffold.of(context).navigateEndDrawerRoute(const NetworkDrawerPage());
  }

  Color _selectForegroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      return DesignColors.blue1_100;
    }
    return DesignColors.gray2_100;
  }
}
