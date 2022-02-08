import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/network_status_list_tile.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class NetworkList extends StatelessWidget {
  const NetworkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkListCubit, NetworkListState>(
      builder: (_, NetworkListState state) {
        if (state is NetworkListLoadedState) {
          int networkListLength = state.networkList.length;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: networkListLength,
            itemBuilder: (_, int index) {
              NetworkModel currentNetwork = state.networkList[index];
              return NetworkStatusListTile(
                networkModel: currentNetwork,
              );
            },
          );
        } else {
          return const CenterLoadSpinner();
        }
      },
    );
  }
}
