import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/network_drawer_page/network_drawer_page.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/network_list/network_status_icon.dart';

class CurrentNetworkButton extends StatelessWidget {
  final NetworkCustomSectionCubit _networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();
  final Size size;

  CurrentNetworkButton({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkModuleBloc, NetworkModuleState>(
      bloc: globalLocator<NetworkModuleBloc>(),
      builder: (_, NetworkModuleState networkModuleState) {
        ANetworkStatusModel networkStatusModel = networkModuleState.networkStatusModel;

        return MouseStateListener(
          onTap: () => _openDrawerNetworkPage(context),
          disableSplash: true,
          childBuilder: (Set<MaterialState> states) {
            Color foregroundColor = _selectForegroundColor(states);
            Color backgroundColor = _selectBackgroundColor(states);

            return Container(
              width: size.width,
              height: size.height,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: foregroundColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NetworkStatusIcon(networkStatusModel: networkStatusModel, size: 13),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        networkStatusModel.name,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          height: 1,
                          color: DesignColors.white1,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
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
            );
          },
        );
      },
    );
  }

  void _openDrawerNetworkPage(BuildContext context) {
    KiraScaffold.of(context).navigateEndDrawerRoute(const NetworkDrawerPage());
    _networkCustomSectionCubit.resetSwitchValueWhenConnected();
  }

  Color _selectForegroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      return DesignColors.white1;
    }
    return DesignColors.greyOutline;
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      return DesignColors.greyHover2;
    }
    return Colors.transparent;
  }
}
