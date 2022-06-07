import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loaded_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

class NetworkList extends StatelessWidget {
  const NetworkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkListCubit, ANetworkListState>(
      builder: (_, ANetworkListState networkListState) {
        if (networkListState is NetworkListLoadedState) {
          int networkListLength = networkListState.networkStatusModelList.length;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: networkListLength,
            itemBuilder: (_, int index) {
              ANetworkStatusModel currentNetwork = networkListState.networkStatusModelList[index];
              return NetworkListTile(networkStatusModel: currentNetwork);
            },
          );
        } else {
          return const CenterLoadSpinner();
        }
      },
    );
  }
}
