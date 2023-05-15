import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_list/a_network_list_state.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/states/network_list_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

class NetworkList extends StatelessWidget {
  final ValueChanged<ANetworkStatusModel>? onConnected;
  final ANetworkStatusModel? hiddenNetworkStatusModel;
  final Widget? emptyListWidget;

  const NetworkList({
    this.onConnected,
    this.hiddenNetworkStatusModel,
    this.emptyListWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkListCubit, ANetworkListState>(
      bloc: globalLocator<NetworkListCubit>(),
      builder: (_, ANetworkListState networkListState) {
        if (networkListState is NetworkListLoadedState) {
          List<ANetworkStatusModel> visibleNetworkStatusModelList = _getVisibleNetworkStatusModelList(networkListState);
          if (visibleNetworkStatusModelList.isEmpty && emptyListWidget != null) {
            return emptyListWidget!;
          }
          return ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleNetworkStatusModelList.length,
            itemBuilder: (_, int index) {
              ANetworkStatusModel currentNetwork = visibleNetworkStatusModelList[index];
              return NetworkListTile(
                networkStatusModel: currentNetwork,
                onConnected: onConnected,
              );
            },
          );
        } else {
          return const CenterLoadSpinner();
        }
      },
    );
  }

  List<ANetworkStatusModel> _getVisibleNetworkStatusModelList(NetworkListLoadedState networkListLoadedState) {
    List<ANetworkStatusModel> availableNetworkStatusModelList = networkListLoadedState.networkStatusModelList;
    if (hiddenNetworkStatusModel == null) {
      return availableNetworkStatusModelList;
    } else {
      List<ANetworkStatusModel> visibleNetworkStatusModelList = availableNetworkStatusModelList.where((ANetworkStatusModel networkStatusModel) {
        return networkStatusModel.uri.host != hiddenNetworkStatusModel!.uri.host;
      }).toList();
      return visibleNetworkStatusModelList;
    }
  }
}
