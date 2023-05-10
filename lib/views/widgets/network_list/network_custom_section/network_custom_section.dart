import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section_content.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section_switch.dart';

class NetworkCustomSection extends StatefulWidget {
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkCustomSection({
    this.onConnected,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSection();
}

class _NetworkCustomSection extends State<NetworkCustomSection> {
  final KiraTextFieldController kiraTextFieldController = KiraTextFieldController();
  final NetworkCustomSectionCubit networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();
  late bool isSectionExpanded = networkCustomSectionCubit.state.isExpanded;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCustomSectionCubit, NetworkCustomSectionState>(
      bloc: networkCustomSectionCubit,
      builder: (_, NetworkCustomSectionState networkCustomSectionState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              NetworkCustomSectionSwitch(
                initialExpanded: isSectionExpanded,
                onChanged: (bool value) => setState(() => isSectionExpanded = value),
              ),
              if (isSectionExpanded)
                NetworkCustomSectionContent(
                  kiraTextFieldController: kiraTextFieldController,
                  onConnected: widget.onConnected,
                  networkCustomSectionCubit: networkCustomSectionCubit,
                ),
            ],
          ),
        );
      },
    );
  }
}
